class Entry < ActiveRecord::Base
  belongs_to :user

  def Entry.register(params, login_user)
    if params[:content]
      Entry.create({
        :user_id => login_user.id,
        :content => params[:content]
      })
    end
  end
end
