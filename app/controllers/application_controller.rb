class ApplicationController < ActionController::Base

  attr_reader :current_user
  helper_method :current_user

  before_action :authenticate_user

  private

  def authenticate_user
    user = SessionManager.new(session).authenticated_user

    if user
      @current_user = user
    else
      redirect_to sign_in_sessions_path, alert: 'Authentication required!'
    end
  end

end
