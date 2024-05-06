class Supervisor::BaseController < ApplicationController
  before_action :require_supervisor!

  def authorize(record, query = nil)
    super([:supervisor, record], query)
  end

  private

  def require_supervisor!
    redirect_to root_path unless current_user.role_supervisor?
  end
end
