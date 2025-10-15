class FixRoleColumnInUsers < ActiveRecord::Migration[8.0]
  def change
    change_column :users, :role, :integer, limit: 4, default: 0
  end
end
