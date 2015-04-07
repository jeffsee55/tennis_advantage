class AdminController < ApplicationController
  before_filter :require_login
  layout 'admin'

  def dashboard
    list_items = [] + Order.all + Product.all +  Page.all + Post.all + Message.all
    list_items.sort! { |a, b| b.updated_at <=> a.updated_at }
    @list_items = Kaminari.paginate_array(list_items).page(params[:page])
  end
end

