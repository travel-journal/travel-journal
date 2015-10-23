class FixFirstName < ActiveRecord::Migration
  def change
    rename_column :users, :firstname, :first_name
  end
end
