class AddHandDeliverOptionToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :hand_deliver, :boolean
  end
end
