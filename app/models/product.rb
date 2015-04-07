class Product < ActiveRecord::Base
  has_many :line_items

  attachment :image_1
  attachment :image_2
  attachment :image_3
  attachment :image_4

  monetize :price_cents

  include Scopes
  scope :by_category, -> { order('category DESC') }

  def to_local_list_item
    {
      img: self,
      color: nil,
      icon: nil,
      primary: self.name,
      link: Rails.application.routes.url_helpers.admin_product_path(self),
      link_text: "Edit",
      secondary: self.description,
      details: "Qty: #{ self.inventory }"
    }
  end

  def image
    image_1
  end
end

