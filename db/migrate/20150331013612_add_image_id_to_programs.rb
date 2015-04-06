class AddImageIdToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :image_1_id, :string
  end
end
