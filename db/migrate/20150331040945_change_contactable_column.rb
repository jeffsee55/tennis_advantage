class ChangeContactableColumn < ActiveRecord::Migration
  def change
    remove_column :users, :contactable?
    add_column :users, :contactable, :boolean
  end
end
