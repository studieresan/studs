class MakeUserLoginUnique < ActiveRecord::Migration
  def up
    add_index :users, :login, :unique => true
  end

  def down
    remove_index :users, :login
  end
end
