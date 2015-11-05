# spec/factories/trip.rb
require 'faker'

FactoryGirl.define do
  factory :trip do |f|
    f.title { Faker::Company.name }
    f.about { Faker::Hacker.say_something_smart }
    f.start_date { Date.today }
    f.end_date { Date.today }

  end


  factory :invalid_trip, parent: :trip do |f|
	  f.title nil
	end


end