class FixPhoneInCoaches < ActiveRecord::Migration
  def change
    remove_column :coaches, :phnoe
    add_column :coaches, :phone, :string
  end
end
