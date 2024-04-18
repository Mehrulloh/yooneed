class Profile::UserController < ApplicationController
    def index; end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      redirect_back fallback_location: root_path, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
  end
end
