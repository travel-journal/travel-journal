class RemoveEmailAddressFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :emailaddress, :string
  end
end
