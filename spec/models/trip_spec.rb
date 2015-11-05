# spec/models/trip_spec.rb
require 'rails_helper'
require 'spec_helper'

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
end