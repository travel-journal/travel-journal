class Post < ActiveRecord::Base
  validates :title, :presence => true
  validates :trip, :presence => true
  validates :date, :presence => true
  validates :like_count, :presence => true
  valides :like_count, :numericality => {
    :only_integer => true,
    :greater_than_or_equal_to => 0
  }
  belongs_to :user
  belongs_to :trip
end
