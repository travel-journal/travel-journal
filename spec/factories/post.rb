# spec/factories/post.rb
require 'faker'

FactoryGirl.define do
  factory :post do |f|
    f.title { Faker::Company.catch_phrase }
    f.date { Date.today }
    f.time { Faker::Time.backward(14, :evening) }
    f.location { Faker::Address.country }
    f.caption { Faker::Hacker.say_something_smart }

    factory :trip_post do |f|
    	f.trip_id { Faker::Number.number(2) }
    end
  end
  
  factory :invalid_post, parent: :post do |f|
	  f.title nil
	end
end
