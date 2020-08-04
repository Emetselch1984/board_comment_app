class AddUserIdToBorads < ActiveRecord::Migration[5.2]
  def change
    add_column :borads, :user_id
  end
end
