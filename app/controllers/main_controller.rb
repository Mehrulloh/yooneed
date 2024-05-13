class MainController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @products = Product.order(:id).decorate
    @orders = Order.all.decorate
  end
end
