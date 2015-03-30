class CreateOrderEvents < ActiveRecord::Migration
  def change
    create_table :order_events do |t|
      t.integer :order_id
      t.string :state

      t.timestamps
    end
  end
end
