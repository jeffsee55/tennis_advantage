class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.float :total
      t.string :stripe_customer_id
      t.string :state
      t.string :city
      t.string :zip
      t.string :street1
      t.string :street2
      t.string :shipment_id
      t.string :name
      t.string :charge_id

      t.timestamps
    end
  end
end
