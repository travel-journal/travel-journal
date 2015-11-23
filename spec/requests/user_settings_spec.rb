require "spec_helper"
require 'rails_helper'

describe "user settings" do

  before :each do
    FactoryGirl.create(:full_user, username: "Claire", password:"hellobear", first_name: "Nishu", last_name: "Tanay", about: "I am a Tanay Nishu combo")

    visit "/users/sign_in"

    fill_in "Username",   :with => "Claire"
    fill_in "Password",   :with => "hellobear"

    click_button "Sign in"

    #visit "/users/edit"
    click_link "Update profile"
  end

  it "has correct info" do
  	
    page.should have_content("Update Profile")
    page.should have_content("Nishu")
    page.should have_content("Tanay")
    page.should have_content("I am a Tanay Nishu combo")
    
  end

  it "able to delete user" do
    click_button "Delete"
    page.should have_content("Bye!")
  end
end