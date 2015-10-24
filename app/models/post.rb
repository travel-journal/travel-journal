class Post < ActiveRecord::Base
  validates :title, :presence => true
  validates :date, :presence => true
  
  # should initialize to 0 in controller?
  #validates :like_count, :presence => true
  #validates :like_count, :numericality => {
  #  :only_integer => true,
  #  :greater_than_or_equal_to => 0
  #}

  
  belongs_to :user
  belongs_to :trip, :foreign_key => :trip_id
  mount_uploader :image, ImageUploader
end
