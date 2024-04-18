class MainController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @products = Product.order(:id).decorate
  end
end
