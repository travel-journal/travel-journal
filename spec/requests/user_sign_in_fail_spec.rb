require "spec_helper"

describe "user sign in failure" do
  it "deny user from signing in if not registered" do

    visit "/users/sign_in"

    fill_in "Username",		:with => "beepbooopppppp2222"
    fill_in "Password", 	:with => "beepbooopppppp2222"

    click_button "Sign in"

    page.should have_content("Invalid username or password.")
  end
end