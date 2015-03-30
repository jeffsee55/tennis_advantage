class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.text :content_a
      t.text :content_b
      t.text :content_c
      t.text :content_d
      t.text :content_f

      t.timestamps
    end
  end
end
