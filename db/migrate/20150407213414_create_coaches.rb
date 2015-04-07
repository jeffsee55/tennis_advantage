class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string :email
      t.string :name
      t.string :phnoe
      t.string :bio
      t.string :image_1_id
      t.boolean :contactable

      t.timestamps
    end
  end
end
