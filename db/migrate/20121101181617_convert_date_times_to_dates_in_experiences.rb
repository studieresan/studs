class ConvertDateTimesToDatesInExperiences < ActiveRecord::Migration
  def up
    change_column :experiences, :start_time, :date, null: false
    change_column :experiences, :end_time, :date
    rename_column :experiences, :start_time, :start_date
    rename_column :experiences, :end_time, :end_date
  end

  def down
    rename_column :experiences, :start_date, :start_time
    rename_column :experiences, :end_date, :end_time
    change_column :experiences, :start_time, :datetime, null: false
    change_column :experiences, :end_time, :datetime
  end
end
