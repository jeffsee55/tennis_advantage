class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  register_currency :aud
  monetize :total_cents, :with_currency => :aud

  default_scope{order("created_at DESC")}

  def to_local_list_item
    {
      img: self.product,
      color: nil,
      icon: nil,
      primary: self.product.name,
      link: Rails.application.routes.url_helpers.product_path(self.product),
      link_text: "Qty: #{ self.qty }",
      secondary: self.product.price,
      details: self.total
    }
  end

  def self.sub_total
    sum = 0
    self.all.map do |line_item|
      sum += line_item.total
    end
    return sum
  end

  def widest_side
    [self.product.length, self.product.width, self.product.height].max
  end

  def next_widest_side
    [self.product.length, self.product.width, self.product.height].sort[-2]
  end

  def narrowest_side
    [self.product.length, self.product.width, self.product.height].min
  end

  def self.dimensions_and_weight
    {
      weight: (all.collect { |line_item| line_item.product.weight }).inject{|sum,x| sum + x }.to_f,
      length: (all.collect { |line_item| line_item.widest_side }).max.to_f,
      height: (all.collect { |line_item| line_item.next_widest_side }).max.to_f,
      width: (all.collect { |line_item| line_item.narrowest_side * line_item.qty }).inject{|sum,x| sum + x }.to_f
    }
  end
end

