require "spec_helper"
require 'rails_helper'

describe "user settings" do
  it "ensure that user setting page updates correctly" do
  	FactoryGirl.create(:full_user, username: "Claire", password:"hellobear", first_name: "Nishu", last_name: "Tanay", about: "I am a Tanay Nishu combo")

    visit "/users/sign_in"

    fill_in "Username",		:with => "Claire"
    fill_in "Password", 	:with => "hellobear"

    click_button "Sign in"

    #visit "/users/edit"
    click_link "Update profile"

    page.should have_content("Update Profile")
    page.should have_content("Nishu")
    page.should have_content("Tanay")
    #page.should have_content("hello@world.com")
    page.should have_content("I am a Tanay Nishu combo")
    
  end
end