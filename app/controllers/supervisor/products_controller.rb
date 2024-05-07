class Supervisor::ProductsController < Supervisor::BaseController
  before_action :authenticate_user!
  before_action :require_supervisor!

  before_action :set_product, only: %i[update accept denied]


  def index
    @products = Product.all.decorate
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :dashboard, status: :ok }
      else
        format.html { redirect_back fallback_location: dashboard_path, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    if @product.processing? && @product.accepted!
      redirect_to dashboard_path, notice: "Product successfully accepted."
    else
      redirect_to dashboard_path, alert: "Failed to update product status."
    end
  end

  def denied
    if @product.denied!
      redirect_back fallback_location: dashboard_path, notice: "Product denied successfully."
    else
      redirect_back fallback_location: dashboard_path, alert: "Failed to deny product."
    end
  end


  private

  def set_product
    @product = Product.find_by(id: params[:id])
  end

  def product_params
    params.require(:product).permit(:id).merge(user: current_user)
  end
end
