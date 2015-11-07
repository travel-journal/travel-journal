require "spec_helper"

describe "user registration password error" do
  it "denies user from registering without Password" do
    visit "/users/sign_up"

    fill_in "Username",				 :with => "Nishu"
    fill_in "Password confirmation", :with => "hellobear"
    fill_in "Email",                 :with => "tanaynishu@example.com"
    fill_in "First name",			 :with => "Tanay"
    fill_in "Last name",			 :with => "Nishu"
    fill_in "About",				 :with => "I am a Tanay Nishu combo"
    

    click_button "Sign up"

    page.should have_content("Password can't be blank")
  end
end