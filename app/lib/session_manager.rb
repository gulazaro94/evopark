class SessionManager
  def initialize(session)
    @session = session
  end

  def authenticate(user)
    @session[:user_id] = user.id
  end

  def authenticated_user
    User.find(@session[:user_id]) if @session[:user_id].present?
  end

  def unauthenticate
    @session.delete(:user_id)
  end
end
