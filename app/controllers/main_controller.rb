class MainController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    load_products
    load_completed_orders
    load_uncompleted_orders
  end

  private

  def load_products
    @products = Product.all.decorate
  end

  def load_completed_orders
    @completed = Order.completed.decorate
  end

  def load_uncompleted_orders
    @uncompleted = Order.uncompleted.decorate
  end
end
