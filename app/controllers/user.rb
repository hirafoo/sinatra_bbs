post '/user/register' do
  @result = User.register(params[:post])
  redirect '/'
end

get '/user/edit/*' do
  if @user = User.find_by_id( params[:splat] )
    erb :'user/edit'
  else
    myerror("user find failed")
  end
end

post '/user/edit/*' do
  pp params[:splat]
  pp params[:post]
  @user = User.find_by_id( params[:splat] )
  params.delete("splat")

  if @user.update_attributes( params[:post] )
    @result = "update success"
    erb :'user/execute'
  else 
    myerror("maybe wrong params")
  end
end
