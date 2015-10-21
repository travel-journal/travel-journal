class Trip < ActiveRecord::Base
    belongs_to :user, :foreign_key => :user_id
    has_many :posts
    validates :title, :about, :startDate, :endDate, presence: true
end
