class DropSlideImages < ActiveRecord::Migration
  def change
    drop_table :slide_images
  end
end
