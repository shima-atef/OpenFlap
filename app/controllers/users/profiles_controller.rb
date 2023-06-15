class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(account_update_params)
      bypass_sign_in(@user)
      redirect_to users_profile_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  private

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :bio)
  end
end
