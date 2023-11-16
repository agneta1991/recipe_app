class ChangeUserIdToNotNull < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :id, :integer, null: false
  end
end
