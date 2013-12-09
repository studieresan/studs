class AddLinkedinUrlToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :linkedin_url, :string
  end
end
