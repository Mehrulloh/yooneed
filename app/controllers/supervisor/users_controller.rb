class Supervisor::UsersController < Supervisor::BaseController
  before_action :set_user, only: %i[show edit update destroy]

  before_action :authorize_user!
  after_action :verify_authorized

  def index
    @users = User.all.decorate
  end

  def show;  end
  def edit; end
  def new; end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to supervisor_users_path, success: "#{@user.name} was created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, success: "#{@user.name} was updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    redirect_to supervisor_users_path, success: "#{@user.name} was deleted!"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :surname, :email, :role,).merge(user: current_user)
  end

  def authorize_user!
    authorize(@user || User)
  end
end
