class ProductVariant < ActiveRecord::Base
  belongs_to :product
  belongs_to :variant
end
