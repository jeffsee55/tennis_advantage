class Variant < ActiveRecord::Base
  has_many :product_variants, dependent: :destroy
  has_many :products, through: :product_variants

  serialize :options

  def name_and_desc
    "#{self.name} (#{self.description})"
  end
end
