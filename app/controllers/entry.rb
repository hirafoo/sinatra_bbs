get '/entry/' do
  if @session
    erb :'entry/index'
  else
    myerror "please login"
  end
end

post '/entry/register' do
  Entry.register(params[:post], @login_user)
  @result = 'post success'
  erb :'entry/register'
end
