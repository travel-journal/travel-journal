class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :title
      t.references :user_id
      t.text :about
      t.date :startDate
      t.date :endDate

      t.timestamps null: false
    end

    add_foreign_key :trips, :users
    
  end
end
