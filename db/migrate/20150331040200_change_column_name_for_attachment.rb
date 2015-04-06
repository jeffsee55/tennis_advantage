class ChangeColumnNameForAttachment < ActiveRecord::Migration
  def change
    remove_column :users, :image_id
    add_column :users, :image_1_id, :string
  end
end
