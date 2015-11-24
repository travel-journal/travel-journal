require "spec_helper"
require 'faker'

describe "User Registration (Integration Tests)" do
  before :each do
    visit "/users/sign_up"
  end

  it "allows new users to register with information" do
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

  it "denies user from registering without email" do

    fill_in "Username",              :with => "Nishu"
    fill_in "Password",              :with => "hellobear"
    fill_in "Password confirmation", :with => "hellobear"
    fill_in "First name",            :with => "Tanay"
    fill_in "Last name",             :with => "Nishu"
    fill_in "About",                 :with => "I am a Tanay Nishu combo"
    

    click_button "Sign up"

    page.should have_content("Email can't be blank")
  end

  it "denies user from registering without Password" do

    fill_in "Username",              :with => "Nishu"
    fill_in "Password confirmation", :with => "hellobear"
    fill_in "Email",                 :with => "tanaynishu@example.com"
    fill_in "First name",            :with => "Tanay"
    fill_in "Last name",             :with => "Nishu"
    fill_in "About",                 :with => "I am a Tanay Nishu combo"
    

    click_button "Sign up"

    page.should have_content("Password can't be blank")
  end
end