# spec/factories/comment.rb
require 'faker'

FactoryGirl.define do
  factory :comment do |f|
    f.body { Faker::Company.catch_phrase }
  end
  
  factory :invalid_comment, parent: :comment do |f|
    f.body nil
  end
end
