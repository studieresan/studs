class AddLinkedInUrlToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :linkedin_url, :string, null: true
  end
end
