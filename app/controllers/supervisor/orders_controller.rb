class Supervisor::OrdersController < Supervisor::BaseController
  before_action :authenticate_user!
  before_action :require_supervisor!

  def index
    @orders = Order.where(status: :processing).decorate(context: { current_user: current_user })
  end
end
