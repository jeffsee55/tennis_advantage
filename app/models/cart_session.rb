class CartSession
  def initialize(session)
    @session = session
    @session[:line_item_ids] ||= []
  end

  def item_count
    line_items.count
  end

  def empty?
    @session[:line_item_ids].blank?
  end

  def add_line_item(line_item)
    @session[:line_item_ids] << line_item.id unless @session[:line_item_ids].include? line_item.id
  end

  def line_items
    LineItem.where(id: @session[:line_item_ids], session_id: @session[:session_id]) if @session[:line_item_ids]
  end

  def remove_line_item(line_item)
    @session[:line_item_ids].delete line_item.id
  end

  def abandon
    line_items.map { |item| item.delete }
    @session[:line_item_ids] = []
  end

  def clear
    @session[:line_item_ids] = []
  end

  def add_order_id(order_id)
    line_items.map do |line_item|
      line_item.order_id = order_id
      line_item.save
    end
    puts "Line Items created"
  end
end
