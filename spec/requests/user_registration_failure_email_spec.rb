require "spec_helper"

describe "user registration email error" do
  it "denies user from registering without email" do
    visit "/users/sign_up"

    fill_in "Username",				 :with => "Nishu"
    fill_in "Password",              :with => "hellobear"
    fill_in "Password confirmation", :with => "hellobear"
    fill_in "First name",			 :with => "Tanay"
    fill_in "Last name",			 :with => "Nishu"
    fill_in "About",				 :with => "I am a Tanay Nishu combo"
    

    click_button "Sign up"

    page.should have_content("Email can't be blank")
  end
end


