class RemoveCategoryIdFromPrograms < ActiveRecord::Migration
  def change
    remove_column :programs, :program_category_id
    add_column :programs, :category, :string, default: "Lessons"
  end
end
