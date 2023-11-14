class ChangeFoodIdToNotNull < ActiveRecord::Migration[7.1]
  def change
    change_column :foods, :id, :integer, null: false
  end
end
