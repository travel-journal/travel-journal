#posts_spec.rb
require "spec_helper"
require 'rails_helper'

describe "Posts (Integration Tests)" do

  before :each do
    FactoryGirl.create(:full_user, username: "tester", password:"tester")
    visit "/users/sign_in"
    fill_in "Username",   :with => "tester"
    fill_in "Password",   :with => "tester"
    click_button "Sign in"

	click_link "Make a new trip"
	fill_in "Title",   :with => "This is my test Title"
	fill_in "About",   :with => "This is my test About"
	click_button "Submit"
	page.should have_content("Trip was successfully created.")

	click_link "Expand"
  end

  describe "Creating" do
    it "able to get to new post form" do
      click_link "Add post"
      page.should have_content("New Post")
    end

    it "able to make new trip" do
      click_link "Add post"
      fill_in "Title",   :with => "BestPost"
      fill_in "Caption",   :with => "AboutBestPost"
      fill_in "Location",   :with => "Berkeley"
      select '2010', from: "post_date_1i"
      select 'January', from: "post_date_2i"
      select '1', from: "post_date_3i"
      select '00', from: "post_time_4i"
      select '00', from: "post_time_5i"

      click_button "Create Post"
      page.should have_content("Post was successfully created.")
    end
  end
end