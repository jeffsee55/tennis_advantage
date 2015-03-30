class AdminController < ApplicationController
  before_filter :require_login
  layout 'admin'

  def dashboard
    list_items = [] + Order.past_week + Product.past_week +  Page.past_week + Post.past_week + Message.past_week
    list_items.sort! { |a, b| b.updated_at <=> a.updated_at }
    @list_items = Kaminari.paginate_array(list_items).page(params[:page])
  end
end

