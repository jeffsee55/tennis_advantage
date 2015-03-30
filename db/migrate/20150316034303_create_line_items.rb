class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :product_id
      t.integer :qty
      t.integer :order_id
      t.string :session_id
      t.integer :total_cents, default: 0, null: false
      t.string :total_currency, default: "USD", null: false

      t.timestamps
    end
  end
end

