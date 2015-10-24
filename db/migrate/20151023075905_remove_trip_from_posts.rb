class RemoveTripFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :trip, :string
  end
end
