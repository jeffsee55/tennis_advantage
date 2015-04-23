class AddVariationToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :variations, :text
  end
end
