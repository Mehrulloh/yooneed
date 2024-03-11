class Supervisor::DashboardController < Supervisor::BaseController

  def index
    @users = User.all
  end

  def edit; end
end
