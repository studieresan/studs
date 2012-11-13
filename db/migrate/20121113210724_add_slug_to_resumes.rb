class AddSlugToResumes < ActiveRecord::Migration
  def up
    add_column :resumes, :slug, :string
    add_index :resumes, :slug, unique: true
    Resume.initialize_urls
  end

  def down
    remove_index :resumes, :slug
    remove_column :resumes, :slug
  end
end
