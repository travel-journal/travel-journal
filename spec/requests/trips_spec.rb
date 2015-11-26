#trips_spec.rb
require "spec_helper"
require 'rails_helper'

describe "Trips (Integration Tests)" do

  before :each do
    FactoryGirl.create(:full_user, username: "tester", password:"tester")
    visit "/users/sign_in"
    fill_in "Username",   :with => "tester"
    fill_in "Password",   :with => "tester"
    click_button "Sign in"
  end

  describe "Creating" do
    it "able to get to new trip form" do
      click_link "Make a new trip"
      page.should have_content("New Trip")
    end

    it "able to make new trip" do
      click_link "Make a new trip"
      fill_in "Title",   :with => "This is my test Title"
      fill_in "About",   :with => "This is my test About"
      click_button "Submit"
      page.should have_content("Trip was successfully created.")
    end
  end

  describe "Editing, Deleting, & Searching" do 
    before :each do
      click_link "Make a new trip"
      fill_in "Title",   :with => "Apple"
      fill_in "About",   :with => "Pie"
      click_button "Submit"
      visit "/api/trips"
    end

    it "able to get to edit form" do
      click_link "Edit"
      page.should have_content("Edit Trip")
    end
    
    it "able to edit" do
      click_link "Edit"
      fill_in "Title",   :with => "Cherry"
      click_button "Submit"
      page.should have_content("Cherry")
    end

    it "able to delete" do
      click_link "Delete"
      page.should have_content("Trip was successfully destroyed.")
    end
  end

  describe "Searching" do 
    it "correct search results" do
      click_link "Make a new trip"
      fill_in "Title",   :with => "Apple"
      fill_in "About",   :with => "Pie"
      click_button "Submit"
      visit "/api/trips"

      click_link "Make a new trip"
      fill_in "Title",   :with => "Cranberry"
      fill_in "About",   :with => "Pie"
      click_button "Submit"
      visit "/api/trips"

      fill_in "search",   :with => "Apple"
      click_button "Search"

      page.should have_content("Apple")
      page.should_not have_content("Cranberry")
    end
  end
end