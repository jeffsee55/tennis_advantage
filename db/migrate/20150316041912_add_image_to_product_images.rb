class AddImageToProductImages < ActiveRecord::Migration
  def change
    add_column :product_images, :image_id, :string
  end
end
