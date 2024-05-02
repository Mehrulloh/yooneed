class MainController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:update, :accept]

  def dashboard
    @products = Product.order(:id).decorate
    @product = Product.new
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    @product.status = :accepted

    if @product.save
      redirect_to main_path(@product)
    else
      redirect_to main_path(@product), alert: "Failed to update product status."
    end
  end


  private

  def set_product
    @product = Product.find_by(id: params[:id])
  end

  def product_params
    params.require(:product).permit(:status, :id).merge(user: current_user)
  end
end
