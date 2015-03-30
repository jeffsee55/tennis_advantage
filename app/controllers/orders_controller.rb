class OrdersController < ApplicationController
  ADDRESS = {
    street1: '164 Townsend Street',
    street2: 'Unit 1',
    city: 'San Francisco',
    state: 'CA',
    zip: '94107'
  }

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    @order.prepare_order(order_params, params[:stripe_token], cart_session.line_items)
    @order.save
    cart_session.add_order_id(@order.id)
    redirect_to edit_order_path(@order)
  rescue => error
    redirect_to new_order_path(errors: error)
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.purchase
    cart_session.clear
    redirect_to products_path, notice: "Thanks"
  end


  private

  def order_params
    params.require(:order).permit(:name, :email, :street1, :street2, :city, :state, :zip, :weight, :height, :length, :width)
  end
end

