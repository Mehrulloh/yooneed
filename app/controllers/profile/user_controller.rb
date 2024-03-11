class Profile::UserController < Profile::BaseController
  def index; end

  def update
    if current_user.update(user_params)
      redirect_to profile_user_index_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation)
  end
end