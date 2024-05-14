class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  before_action :set_order, except: [:create]

  def create
    @order = @product.orders.new(order_params)

    if @order.save && @order.processing!
      redirect_back fallback_location: root_path, alert: "Your order has been processed successfully."
    else
      redirect_back fallback_location: root_path, alert: "#{@order.name} wurde schon bestellt!"
    end
  end

  def accept
      if @order.save && @order.accepted!
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

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:product_id, :name, :amount).merge(user: current_user)
  end
end
