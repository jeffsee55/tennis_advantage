class AddImageIdsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :image_1_id, :string
    add_column :products, :image_2_id, :string
    add_column :products, :image_3_id, :string
    add_column :products, :image_4_id, :string
  end
end
