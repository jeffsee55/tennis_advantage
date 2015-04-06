class CartSessionsController < ApplicationController
  before_filter :verify_cart_items, only: :show
  def show
    @line_items = cart_session.line_items
    @page = Page.find_by_slug("cart")
  end

  def destroy
    cart_session.abandon
    redirect_to products_path, notice: "Cart is empty"
  end

  private

    def verify_cart_items
      redirect_to products_path, notice: "Your cart is empty." if cart_session.empty?
    end
end

