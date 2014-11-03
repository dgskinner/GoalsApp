require 'rails_helper'

feature "the signup process" do 
  before :each do
    visit new_user_url
  end

  it "has a new user page" do
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      sign_up("user_name", "password")
      expect(page).to have_content("user_name")
    end
    
    it "shows error on signup page if signup fails" do
      fill_in("Username", with: "")
      fill_in("Password", with: "")
      click_button("Sign Up")
      
      expect(page).to have_content("Username can't be blank")
      expect(page).to have_content("Password is too short (minimum is 6 characters)")
    end
  end

end

feature "logging in" do 
  before :each do
    visit new_user_url
    sign_up("Dave", "daveword")
    click_button("Log Out")
  end
  
  it "shows username on the homepage after login" do
    fill_in("Username", with: "Dave")
    fill_in("Password", with: "daveword")
    click_button("Log In")
    
    expect(page).to have_content("Dave")
  end
  
  it "shows error on signin page if signup fails" do
    fill_in("Username", with: "")
    fill_in("Password", with: "")
    click_button("Log In")
    
    expect(page).to have_content("Invalid Username or Password")
  end
  
end

feature "logging out" do 
  before :each do
    visit new_user_url
    sign_up("Dave", "daveword")
    click_button("Log Out")
  end

  it "begins with logged out state" do
    visit user_url(1)
    expect(page).to have_content("Log In")
  end

  it "doesn't show username on the homepage after logout" do
    expect(page).not_to have_content("Dave")
  end
end