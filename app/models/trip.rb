class Trip < ActiveRecord::Base
    belongs_to :user, :foreign_key => :user_id
    has_many :posts, :dependent => :destroy
    validates :title, :about, :start_date, :end_date, presence: true
    

    validate :end_after_start
    validates :start_date, :end_date, :presence => true

    private
    def end_after_start
      return if end_date.blank? || start_date.blank?
     
      if end_date < start_date
        errors.add(:end_date, "must be after the start date") 
      end 
     end



    def self.search(search)
      where("title LIKE ? OR about LIKE ?", "%#{search}%", "%#{search}%")
	end
end
