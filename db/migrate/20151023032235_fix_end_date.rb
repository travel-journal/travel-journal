class FixEndDate < ActiveRecord::Migration
  def change
    rename_column :trips, :endDate, :end_date
  end
end
