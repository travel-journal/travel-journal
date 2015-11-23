require "spec_helper"
require 'faker'

describe "Homepage Activities (Integration Tests)" do
  it "able to get to registration page" do
    visit "/"
    within("nav") do
        click_link "Sign up"
    end
    page.should have_content("Sign Up")
  end

  it "able to get to sign in page" do
    visit "/"
    within("nav") do
        click_link "Sign in"
    end
    page.should have_content("Sign In")
  end
end