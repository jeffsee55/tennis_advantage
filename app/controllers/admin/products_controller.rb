class Admin::ProductsController < AdminController
  before_action :set_admin_product, only: [:show, :edit, :update, :destroy]
  before_action :update_variants, only: [:create, :update]

  def index
    @products = Product.all.by_category.page params[:page]
  end

  def show
  end

  def new
    @product = Product.new
    @product.product_variants.build.build_variant
  end

  def edit
  end

  def create
    @product = Product.new(admin_product_params)

    if @product.save
      admin_product_params[:variant_ids].map do |v|
        ProductVariant.create(product_id: @product.id, variant_id: v.id)
      end
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
      params.require(:product).permit(:name, :description, :price, :weight, :length, :category, :height, :width, :image_1, :image_2, :image_3, :image_4, variant_ids: [])
    end

    def update_variants
      if admin_product_params[:variant_ids]
        @product.product_variants.delete_all
        admin_product_params[:variant_ids].map do |id|
          @product.product_variants.create!(variant_id: id)
        end
      end
      puts "Updated variants"
    end

end
