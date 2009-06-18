class Session < ActiveRecord::Base
  serialize :data

  def Session.auth(params, session_id)
    (result, login_user) = [nil, nil]

    if login_user = User.find_by_name_and_password( params[:name], params[:password] )
      session = {:user => login_user}
      session = Base64.b64encode( Marshal.dump(session) )
      Session.new(:session_id => session_id, :data => session).save

      result = 'login ok, session create.'
    else
      result = 'login ng.'
    end

    return result, login_user
  end
end
