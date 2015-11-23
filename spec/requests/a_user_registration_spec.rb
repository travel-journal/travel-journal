require "spec_helper"
require 'faker'

describe "user registration" do
  it "allows new users to register with information" do
    visit "/users/sign_up"

    fill_in "Username",				 :with => "Nishu"
    fill_in "Password",              :with => "hellobear"
    fill_in "Password confirmation", :with => "hellobear"
    fill_in "Email",                 :with => "hello@world.com"
    fill_in "First name",			 :with => "Tanay"
    fill_in "Last name",			 :with => "Nishu"
    fill_in "About",				 :with => "I am a Tanay Nishu combo"
    

    click_button "Sign up"

    page.should have_content("Welcome! You have signed up successfully.")
  end
end