class TrimWhitespaceInTableColumns < ActiveRecord::Migration
  COLUMNS = {
    experiences: %w(organization location title description),
    resumes: %w(name email phone masters presentation),
    users: %w(email name)
  }

  def up
    COLUMNS.each do |table,cols|
      values = cols.map { |col| "#{col} = TRIM(#{col})" }.join(', ')
      execute "UPDATE #{table} SET #{values}"
    end
  end

  def down
  end
end
