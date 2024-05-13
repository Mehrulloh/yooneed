class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[processing accept deny]

  def create
    @order = Order.new order_params

    if @order.save
      redirect_back fallback_location: root_path, alert: "Your orders has been processed successfully."
    elsif @order.present?
      redirect_back fallback_location: root_path, alert: "#{@order.name} exists already!!!"
    end
  end

  def processing
    if @order.processing!
      redirect_back fallback_location: root_path, alert: "Your orders has been processed successfully."
    else
      redirect_back fallback_location: root_path, alert: "Failed to update orders status."
    end
  end

  def accept
    if @order.processing? && @order.accepted!
      redirect_back fallback_location: root_path, notice: "Product successfully accepted."
    else
      redirect_back fallback_location: root_path, alert: "Failed to update orders status."
    end
  end

  def deny
    if @order.denied!
      redirect_back fallback_location: root_path, notice: "Order denied successfully."
    else
      redirect_back fallback_location: root_path, alert: "Failed to deny orders."
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:id, :name, :amount, :user_id, :status)
  end
end
