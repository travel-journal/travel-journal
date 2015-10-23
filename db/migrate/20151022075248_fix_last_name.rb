class FixLastName < ActiveRecord::Migration
  def change
    rename_column :users, :lastname, :last_name 
  end
end
