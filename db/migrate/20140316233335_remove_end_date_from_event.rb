class RemoveEndDateFromEvent < ActiveRecord::Migration
  def up
    remove_column :events, :end_date
  end

  def down
    add_column :events, :end_date, :datetime
  end
end
