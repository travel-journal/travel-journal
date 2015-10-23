class FixStartDate < ActiveRecord::Migration
  def change
    rename_column :trips, :startDate, :start_date
  end
end
