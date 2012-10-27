class AddMastersProgrammeAndPresentationToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :masters, :string
    add_column :resumes, :presentation, :text
  end
end
