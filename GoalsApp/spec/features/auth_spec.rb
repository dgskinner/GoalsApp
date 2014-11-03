require 'spec_helper'

feature "the signup process" do 
  before :each do
    visit new_user_url
  end

  it "has a new user page" do
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      fill_in("Username", with: "new_user")
      fill_in("Password", with: "password")
      click_button("Sign Up")
      
      expect(page).to have_content("new_user")
    end
    
    it "shows error on signup page if signup fails" do
      fill_in("Username", with: "")
      fill_in("Password", with: "")
      click_button("Sign Up")
      
      expect(page).to have_content("Username can't be blank")
      expect(page).to have_content("Password must be at least 6 characters")
    end
  end

end

feature "logging in" do 

  it "shows username on the homepage after login" do
  end

end

feature "logging out" do 

  it "begins with logged out state"

  it "doesn't show username on the homepage after logout"

end