class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :phone, :string
    add_column :users, :bio, :string
    add_column :users, :contactable?, :boolean
  end
end
