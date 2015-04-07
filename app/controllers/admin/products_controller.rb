class Admin::ProductsController < AdminController
  before_action :set_admin_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all.by_category.page params[:page]
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(admin_product_params)

    if @product.save
      redirect_to admin_product_path(@product), notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product.update(admin_product_params)
      redirect_to admin_product_path(@product), notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_url, alert: 'Product was successfully destroyed.'
  end

  private
    def set_admin_product
      @product = Product.find(params[:id])
    end

    def admin_product_params
      params.require(:product).permit(:name, :description, :price, :weight, :length, :height, :width, :image_1, :image_2, :image_3, :image_4)
    end
end
