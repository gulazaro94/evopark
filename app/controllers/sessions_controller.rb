class SessionsController < ApplicationController

  skip_before_action :authenticate_user, only: [:sign_in, :authenticate]

  def sign_in
  end

  def authenticate
    outcome = Users::Authenticate.run(email: params[:email], password: params[:password])

    if outcome.valid?
      SessionManager.new(session).authenticate(outcome.result)
      redirect_to reminders_path
    else
      redirect_to sign_in_sessions_path, alert: 'Fail to sign in'
    end
  end

  def unauthenticate
    SessionManager.new(session).unauthenticate

    redirect_to sign_in_sessions_path
  end
end
