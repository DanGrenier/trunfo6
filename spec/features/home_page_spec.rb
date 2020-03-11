require 'rails_helper'

RSpec.feature "Home Page", :type => :feature do 
  let!(:user) {create(:user)}

  scenario "When Not Logged In" do 
  	visit "/"
  	expect(page).to have_selector("img#main-logo")
  end

  scenario "When Logged In" do 
  	visit new_user_session_path
  	fill_in 'Email', with: user.email 
  	fill_in 'Password', with: user.password
  	click_button 'Log In'
  	visit "/"
  	expect(page).to_not have_selector "img#main-logo"
  	expect(page).to have_link("Log Out")

  end


end