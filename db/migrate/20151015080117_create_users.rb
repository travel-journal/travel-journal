class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :firstname
      t.string :lastname
      t.string :emailaddress
      t.text :about

      t.timestamps null: false
    end
  end
end
