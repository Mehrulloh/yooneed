class ProductsController < ApplicationController
  before_action :authenticate_user!,            except: %i[index]
  before_action :set_product,  only: %i[show edit update destroy]
  before_action :authorize_product!,  only: %i[edit update destroy]
  after_action  :verify_authorized, only: %i[edit update destroy]

  def index
    @products = Product.all.decorate
  end

  def edit; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to root_path, notice: "Product was successfully created." }
        format.json { render :index, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to root_path, notice: "Product was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :packing_type, :active, :image)
    end

  def authorize_product!
    authorize(@product || Product)
  end
end
