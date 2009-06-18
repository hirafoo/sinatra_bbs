before do
  @users = User.all
  page = (params[:page] ? params[:page] : 1).to_i
  (@prev, @next) = [page - 1, page + 1]
  @entries = Entry.paginate(:page => params[:page], :per_page => 10, :order => 'created_at DESC')

  # limit = Time.now.advance(:hours => -9).to_s(:db)
  if request.cookies['rack.session']
    session_id = Digest::SHA1.hexdigest( request.cookies['rack.session'] )
    if @session = Session.find_by_session_id( session_id )
      @login_user = @session.data
      @login_user = Marshal.load( Base64.decode64(@login_user) )
      @login_user = @login_user[:user]
    end
  end
end

get '/' do
  erb :index
end

not_found do
  'This is nowhere to be found'
end


### util 
def myerror(error)
  @error = error
  erb :error
end

def encrypt(plain_text, salt)
  enc = OpenSSL::Cipher::Cipher.new('aes256')
  enc.encrypt
  enc.pkcs5_keyivgen(salt)
  ((enc.update(plain_text) + enc.final).unpack("H*")).to_s
  rescue
    false
end

def decrypt(cipher_text, salt)
  dec = OpenSSL::Cipher::Cipher.new('aes256')
  dec.decrypt
  dec.pkcs5_keyivgen(salt)
  (dec.update(Array.new([cipher_text]).pack("H*")) + dec.final)
  rescue
    false
end

