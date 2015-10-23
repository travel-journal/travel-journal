class AddCommentsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :comments, :string, array: true, default: '{}'
  end
end
