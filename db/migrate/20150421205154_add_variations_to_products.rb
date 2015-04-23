class AddVariationsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :variations, :text
  end
end
