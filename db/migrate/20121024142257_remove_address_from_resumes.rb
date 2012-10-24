class RemoveAddressFromResumes < ActiveRecord::Migration
  def up
    remove_column :resumes, :address
  end

  def down
    add_column :resumes, :address, :string
  end
end
