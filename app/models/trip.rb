class Trip < ActiveRecord::Base
    belongs_to :user
    has_many :posts
    validates :title, :about, :startDate, :endDate, presence: true
end
