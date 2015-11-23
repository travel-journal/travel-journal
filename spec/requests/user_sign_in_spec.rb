require "spec_helper"
require 'rails_helper'

describe "user sign in" do
  it "allows users to sign in after they have registered" do
  	FactoryGirl.create(:user, username: "Nishu", password:"hellobear")

    visit "/users/sign_in"

    fill_in "Username",		:with => "Nishu"
    fill_in "Password", 	:with => "hellobear"

    click_button "Sign in"

    page.should have_content("Signed in successfully.")
  end
end