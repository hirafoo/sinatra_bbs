class User < ActiveRecord::Base
  has_many :entries

  def User.register(params)
    if params[:name] and params[:password]
      User.create({
        :name     => params[:name],
        :password => params[:password]
      })
      return true
    else
      return false
    end
  end

end
