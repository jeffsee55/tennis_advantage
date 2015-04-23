class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit]
  before_action :authorize_line_edit, only: :edit

  def create
    variations = params[:variations].map { |v| v[1] }.join(" | ") if params[:variations]
    @line_item = LineItem.where(product_id: line_item_params[:product_id], session_id: session["session_id"], variations: variations, order_id: nil).first_or_create.tap do |line_item|
      qty = line_item.qty
      line_item.session_id = session["session_id"]
      line_item.qty = line_item_params[:qty].to_i + qty.to_i
      line_item.total_cents = line_item.product.price_cents * line_item.qty
      line_item.variations = params[:variations].map { |v| v[1] }.join(" | ") if params[:variations]
      line_item.save
      cart_session.add_line_item(line_item)
    end
    respond_to do |format|
      format.html { redirect_to cart_path, notice: "Product was successfully added" }
      format.js { cart_session }
    end
  end

  def destroy
    cart_session.remove_line_item(@line_item)
    session["line_item_ids"] - @line_item.id
    @line_item.delete
    redirect_to :back, notice: "Product was removed from you cart"
  end

  def adjust_qty_to
    @line_item = LineItem.find(params[:id])
    @line_item.qty += (params[:qty].to_i)
    if params[:qty].to_i > 0
      @line_item.total += @line_item.product.price
    else
      @line_item.total -= @line_item.product.price
    end
    if @line_item.qty <= 0
      cart_session.remove_line_item(@line_item)
    end
    @line_item.save
    if cart_session.empty?
      render :js => "window.location = '/products'"
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  private

    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:product_id, :qty, :variations, :session_id)
    end
end

