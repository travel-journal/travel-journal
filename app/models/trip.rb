class Trip < ActiveRecord::Base
    belongs_to :user, :foreign_key => :user_id
    has_many :posts
    validates :title, :about, :start_date, :end_date, presence: true

    def self.search(search)
      where("title LIKE ? OR about LIKE ?", "%#{search}%", "%#{search}%")
	end
end
