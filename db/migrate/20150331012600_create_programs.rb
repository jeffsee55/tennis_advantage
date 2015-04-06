class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.text :description
      t.integer :program_category_id

      t.timestamps
    end
  end
end
