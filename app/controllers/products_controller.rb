class ProductsController < ApplicationController
  before_action :set_product, only: :show
  def show
    @products = Product.all
  end

  def index
    @tournament_player_products = Product.where(category: "Tournament Player")
    @junior_player_products = Product.where(category: "Junior Player")
    @competition_player_products = Product.where(category: "Competition and Intermediate Player")
    @page = Page.find_by_slug("products")
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end
end

