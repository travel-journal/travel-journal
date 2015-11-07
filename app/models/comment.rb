class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :body, :presence => true
  # validates :commenter, :presence => true
end
