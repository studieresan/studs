class AddKindToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :kind, :string, null: false, default: 'work'
  end
end
