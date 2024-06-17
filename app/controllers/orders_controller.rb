class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, except: [:create, :new]

  def new
    @product = Product.find(params[:product_id])

    @order = @product.orders.build
  end

  def create
    @order = Order.find_or_initialize_by(product_id: order_params[:product_id], status: :processing)

    if @order.new_record?
      @order.amount = order_params[:amount]
      @order.user = current_user

      if @order.save
        handle_successful_order
      else
        handle_order_failure
      end
    else
      handle_existing_order
    end
  end

  def accept
    if @order.accepted!
      redirect_back fallback_location: root_path, notice: "Order successfully accepted."
    else
      redirect_back fallback_location: root_path, alert: "Failed to update order status."
    end
  end

  def deny
    if @order.denied!
      redirect_back fallback_location: root_path, notice: "Order denied successfully."
    else
      redirect_back fallback_location: root_path, alert: "Failed to deny order."
    end
  end

  private

  def handle_successful_order
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Your order has been processed successfully." }
      format.turbo_stream
    end
  end

  def handle_existing_order
    respond_to do |format|
      format.html { redirect_to dashboard_path, alert: "#{@order.name} wurde schon bestellt!" }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(:turbo_notifications, partial: 'partials/turbo_notification', locals: { type: :info, data: "#{@order.name} wurde schon bestellt!" }) }
    end
  end

  def handle_order_failure
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, alert: "Failed to process the order." }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(:turbo_notifications, partial: 'partials/turbo_notification', locals: { type: :info, data: "Failed to process the order." }) }
    end
  end

  def set_product
    @product = Product.find(order_params[:product_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:product_id, :amount)
  end
end