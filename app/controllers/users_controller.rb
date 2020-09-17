class UsersController < ApplicationController

  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = Users::Create.run!(user_params)

    if @user.persisted?
      redirect_to sign_in_sessions_path , notice: 'User successfully created.'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
