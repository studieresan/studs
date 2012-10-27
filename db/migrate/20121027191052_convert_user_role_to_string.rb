class ConvertUserRoleToString < ActiveRecord::Migration
  def up
    change_column :users, :role, :string, null: false, default: 'organization'
  end

  def down
    change_column :users, :role, :int, null: false, default: 0
  end
end
