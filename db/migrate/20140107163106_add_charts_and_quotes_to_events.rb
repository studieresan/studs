class AddChartsAndQuotesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :charts, :text
    add_column :events, :quotes, :text
  end
end
