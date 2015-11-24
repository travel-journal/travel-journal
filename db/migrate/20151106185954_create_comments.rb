class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :post, index: true, foreign_key: true
      t.text :body
      t.string :commenter
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
