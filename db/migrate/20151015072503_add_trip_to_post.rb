class AddTripToPost < ActiveRecord::Migration
  def change
    add_reference :posts, :trip, index: true, foreign_key: true
  end
end
