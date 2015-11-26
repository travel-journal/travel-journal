# spec/models/post_spec.rb
require 'rails_helper'
require 'spec_helper'

describe Post do
  it "has a valid factory" do
  	FactoryGirl.create(:post).should be_valid
  end 

  it "has a valid photo factory" do
  	FactoryGirl.create(:post_photo).should be_valid
  end 

  it "is invalid without a title" do 
  	FactoryGirl.build(:post, title: nil).should_not be_valid
  end

  it "is invalid without a date" do 
  	FactoryGirl.build(:post, date: nil).should_not be_valid
  end
end
