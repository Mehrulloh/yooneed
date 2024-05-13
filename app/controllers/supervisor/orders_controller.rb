class Supervisor::OrdersController < Supervisor::BaseController
  before_action :authenticate_user!
  before_action :require_supervisor!

  def index
    @orders = Order.all
  end
end
