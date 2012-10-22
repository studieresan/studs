class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.references :user # author
      t.string :name, :null => false
      t.date :birthdate
      t.string :email
      t.string :phone
      t.string :address
      t.timestamps
    end
  end
end
