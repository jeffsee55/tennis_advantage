class CreateProgramCategories < ActiveRecord::Migration
  def change
    create_table :program_categories do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
