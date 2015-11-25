require "spec_helper"
require 'rails_helper'

describe "User Sign In (Integration Tests)" do

  before :each do
    visit "/users/sign_in"
  end

  it "allows users to sign in after they have registered" do
  	FactoryGirl.create(:user, username: "Nishu", password:"hellobear")

    fill_in "Username",		:with => "Nishu"
    fill_in "Password", 	:with => "hellobear"

    click_button "Sign in"

    page.should have_content("Signed in successfully.")
  end

  it "deny user from signing in if not registered" do

    visit "/users/sign_in"

    fill_in "Username",		:with => "beepbooopppppp2222"
    fill_in "Password", 	:with => "beepbooopppppp2222"

    click_button "Sign in"

    page.should have_content("Invalid username or password.")
  end
end