class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :trip
      t.text :caption
      t.string :location
      t.date :date
      t.time :time
      t.integer :like_count

      t.timestamps null: false
    end
  end
end
