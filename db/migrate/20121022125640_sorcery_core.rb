class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login, :null => false
      t.string :email, :default => nil
      t.string :password_hash, :default => nil
      t.string :password_salt, :default => nil
      t.string :name, :default => nil
      t.integer :role, :default => 1, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
