# spec/factories/post.rb
require 'faker'

FactoryGirl.define do
  factory :post do |f|
    f.title { Faker::Company.catch_phrase }
    f.date { Date.today }

    factory :trip_post do |f|
    	f.trip_id { Faker::Number.number(2) }
    end
  end
  
  factory :invalid_post, parent: :post do |f|
	  f.title nil
	end


end

# FactoryGirl.define do
#   factory :account do
#     email { Faker::Internet.email }
#     password "password"
#     password_confirmation "password"
#     confirmed_at Date.today
#   end
# end