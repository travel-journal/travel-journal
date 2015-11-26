# spec/models/user_spec.rb
require 'rails_helper'
require 'spec_helper'

describe User do
  it "has a valid factory" do
  	FactoryGirl.create(:user).should be_valid
  end 

  it "is invalid without a email" do 
  	FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it "is invalid without a password" do 
  	FactoryGirl.build(:user, password: nil).should_not be_valid
  end
   
  it "has valid full_user factory" do 
  	FactoryGirl.create(:full_user, username: "Nishu", password:"hellobear", first_name: "Nishu", last_name: "Tanay", about: "This is me!").should be_valid
  end
end
