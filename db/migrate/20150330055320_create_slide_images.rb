class CreateSlideImages < ActiveRecord::Migration
  def change
    create_table :slide_images do |t|
      t.string :image_id

      t.timestamps
    end
  end
end
