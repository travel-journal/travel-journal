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


    # it "able to make new post" do
    #   click_link "Add post"
    #   fill_in "Default title",   :with => "BestPost"
    #   fill_in "Default caption",   :with => "AboutBestPost"


    #   # fill_in "Location",   :with => "Berkeley"
    #   # select '2010', from: "post_date_1i"
    #   # select 'January', from: "post_date_2i"
    #   # select '1', from: "post_date_3i"
    #   # select '00', from: "post_time_4i"
    #   # select '00', from: "post_time_5i"

    #   #click_button "Create Post"
    #   page.should have_content("Verify Upload")
    # end
  end

  describe "Time of Day Filters" do 
    it "able to see morning selection" do
      click_link "Morning"
      page.should have_content("Back")
    end

    it "able to see afternoon selection" do
      click_link "Afternoon"
      page.should have_content("Back")
    end

    it "able to see evening selection" do
      click_link "Evening"
      page.should have_content("Back")
    end
  end

  describe "Map View" do 
    it "able to see morning map view" do
      click_link "Map"
      page.should have_content("Back")
    end
  end

  # describe "Editing, Deleting, & Searching" do 
  #   before :each do
  #     click_link "Add post"
  #     fill_in "Default title",   :with => "BestPost"
  #     fill_in "Default caption",   :with => "AboutBestPost"

  #     pic = fixture_file_upload('files/camp.jpg','image/jpeg')

  #     post :bookmark, :bulkfile => pic

  #     click_button "Create"
  #     # fill_in "Location",   :with => "Berkeley"
  #     # select '2010', from: "post_date_1i"
  #     # select 'January', from: "post_date_2i"
  #     # select '1', from: "post_date_3i"
  #     # select '00', from: "post_time_4i"
  #     # select '00', from: "post_time_5i"

  #     click_button "Create Post"
  #   end

  #   it "able to get to edit form" do
  #     click_link "Edit"
  #     page.should have_content("Edit Post")
  #   end
    
  #   it "able to edit" do
  #     click_link "Edit"
  #     fill_in "Title",   :with => "Cherry"
  #     click_button "Update Post"
  #     page.should have_content("Cherry")
  #   end

  #   it "able to delete" do
  #     click_link "Delete"
  #     page.should have_content("Post was successfully destroyed.")
  #   end


  # end
end