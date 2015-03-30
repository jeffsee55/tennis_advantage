class ChangeAttachmentName < ActiveRecord::Migration
  def change
    remove_column :posts, :image_id
    add_column :posts, :image_1_id, :string
  end
end
