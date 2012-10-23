class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.references :resume
      t.datetime :start_time, null: false
      t.datetime :end_time, null: true
      t.string :organization, null: false
      t.string :location, null: false
      t.string :title, null: false
      t.text :description
      t.timestamps
    end
  end
end
