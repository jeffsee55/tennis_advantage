class Product < ActiveRecord::Base
  has_many :line_items
  has_many :product_variants, dependent: :destroy
  has_many :variants, through: :product_variants

  attachment :image_1
  attachment :image_2
  attachment :image_3
  attachment :image_4


  register_currency :aud
  monetize :price_cents, :with_currency => :aud

  include Scopes
  scope :by_category, -> { order('category DESC') }

  GRIP_SIZES=["L2", "L3", "L4"]
  CATEGORIES=["Tournament Racquets", "Competition, Intermediate & Junior Racquets"]

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

