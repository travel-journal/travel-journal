# spec/models/trip_spec.rb
require 'rails_helper'
require 'spec_helper'
require 'faker'

describe Trip do
  it "has a valid factory" do
  	FactoryGirl.create(:trip).should be_valid
  end 

  it "is invalid without a title" do 
  	FactoryGirl.build(:trip, title: nil).should_not be_valid
  end

  it "is invalid without a about" do 
  	FactoryGirl.build(:trip, about: nil).should_not be_valid
  end

  it "is invalid without a start_date" do 
  	FactoryGirl.build(:trip, start_date: nil).should_not be_valid
  end

  it "is invalid without a end_date" do 
  	FactoryGirl.build(:trip, end_date: nil).should_not be_valid
  end

  it "is invalid when end_date is before start_date" do
    FactoryGirl.build(:trip, start_date: Date.today, end_date: Faker::Date.between(2.days.ago, 2.days.ago)).should_not be_valid
  end

  it "returns correct search results" do
    title1 = Faker::Company.name
    title2 = Faker::Company.name
    trip = FactoryGirl.create(:trip, title: title1)
    other_trip = FactoryGirl.create(:trip, title: title2)
    Trip.search(title1).should == [trip]
  end

  it "does not return invalid search research" do 
    title1 = Faker::Company.name
    title2 = Faker::Company.name
    trip = FactoryGirl.create(:trip, title: title1)
    other_trip = FactoryGirl.create(:trip, title: title2)
    Trip.search(title1).should_not include other_trip
  end
end