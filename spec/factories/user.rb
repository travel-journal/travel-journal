# spec/factories/user.rb
require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.email { Faker::Internet.email }
    f.password "PASSWORD"
  end
end
