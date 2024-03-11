class Supervisor::BaseController < ApplicationController
  before_action :require_supervisor!

  private

  def require_supervisor!
    redirect_to root_path unless current_user.has_role? :supervisor
  end
end
