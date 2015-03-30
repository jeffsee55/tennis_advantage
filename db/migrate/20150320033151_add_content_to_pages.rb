class AddContentToPages < ActiveRecord::Migration
  def change
    add_column :pages, :content_e, :text
  end
end
