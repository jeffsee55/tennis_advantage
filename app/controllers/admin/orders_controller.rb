class Admin::OrdersController < AdminController
  before_action :set_order, only: [:show, :edit, :update, :ship]

  def show
  end

  def edit
  end

  def index
    @orders = Order.all.page params[:page]
  end

  def update
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end

  def ship
    @order.ship
    redirect_to admin_order_path(@order), notice: "Shipping label has been purchased"
  end

  def recalculate_shipping
    @order = Order.find(params[:id])
    @order.recalculate_shipping(order_params)
    redirect_to :back
  end

  def deliver
    @order = Order.find_by_shipment_id(params[:result][:shipment_id])
    @order.deliver
    render :success
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :street1, :street2, :city, :state, :zip, :weight, :height, :length, :width)
    end
end

