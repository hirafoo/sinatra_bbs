#SALT = 'dff5fa8e8d175a83f30212f1413edf96674a4fef5790f92556030a5c46'

post '/auth/login' do
  session_id = Digest::SHA1.hexdigest( request.cookies['rack.session'] )
  (@result, @login_user) = Session.auth(params[:post], session_id)
  erb :'auth/index'
end

get '/auth/logout' do
  if @session
    Session.find_by_session_id( @session.session_id ).delete
  end

  @result = 'logout !'
  @login_user = nil
  erb :'auth/index'
end
