# spec/models/comment_spec.rb
require 'rails_helper'
require 'spec_helper'

describe Comment do
  it "has a valid factory" do
  	FactoryGirl.create(:comment).should be_valid
  end 

  it "is invalid without a body" do 
  	FactoryGirl.build(:comment, body: nil).should_not be_valid
  end
end
