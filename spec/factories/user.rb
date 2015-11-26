# spec/factories/user.rb
require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.email { Faker::Internet.email }
    f.password "PASSWORD"
  end

  factory :full_user, parent: :user do |f|
	f.first_name "first"
	f.last_name "last"
	f.about "About Me!"
  end
end
