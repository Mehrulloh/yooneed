class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:create]
  before_action :set_order, except: [:create, :new]

  def new
    @product = Product.find(params[:product_id])

    @order = @product.orders.new
    respond_to do |format|
      format.html { render :new }
      format.turbo_stream { render :new }
    end
  end

  def create
    if Order.exists?(order_params.except(:status))
      respond_to do |format|
        format.html { redirect_to root_path, alert: "#{@product.name} wurde schon bestellt!" }
        format.turbo_stream
      end
    else
      @order = @product.orders.new(order_params)

      respond_to do |format|
        if @order.save
          format.html { redirect_to root_path, notice: "Your order has been processed successfully." }
          format.turbo_stream
        else
          format.html { redirect_back fallback_location: root_path, alert: "Failed to process the order." }
          format.turbo_stream { render turbo_stream: turbo_stream.replace('flash', partial: 'shared/flash', locals: { alert: "Failed to process the order." }) }
        end
      end
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

  def set_product
    @product = Product.find(order_params[:product_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:product_id, :name, :amount).merge(user_id: current_user.id, status: :processing)
  end
end