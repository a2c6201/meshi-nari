class AddIndexToMenusUserId < ActiveRecord::Migration[7.0]
  def change
    add_index :menus, :user_id
  end
end
