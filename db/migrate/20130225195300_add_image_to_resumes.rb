class AddImageToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :image, :string
  end
end
