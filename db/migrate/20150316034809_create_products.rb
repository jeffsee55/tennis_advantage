class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :weight
      t.integer :length
      t.integer :width
      t.integer :height
      t.integer :price_cents, default: 0, null: false
      t.string :price_currency, default: "USD", null: false

      t.timestamps
    end
  end
end
