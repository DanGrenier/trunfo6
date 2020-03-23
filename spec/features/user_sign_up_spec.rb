require 'rails_helper'

RSpec.feature "Visitor Sign-Up", :type => :feature do
  
  scenario "With invalid email" do
    visit "/"
    find("#registration_link").click
    expect(page).to have_content "Sign Up"
    expect(page).to have_button "Sign Up"
    fill_in "Email", with: 'userexamplecom'
    fill_in "Password", with: 'password'
    fill_in "Password Confirmation", with: 'password'
    click_button 'Sign Up'
    expect(page).to have_content "Sign Up"
    expect(page).to have_button "Sign Up"
  end

  scenario "With invalid password" do
    visit "/"
    find("#registration_link").click
    expect(page).to have_content "Sign Up"
    expect(page).to have_button "Sign Up"
    fill_in "Email", with: 'user@example.com'
    fill_in "Password", with: 'a'
    fill_in "Password Confirmation", with: 'a'
    click_button 'Sign Up'
    expect(page).to have_content "Password is too short"
    expect(page).to have_button "Sign Up"
  end

  scenario "With wrong password confirmation" do
    visit "/"
    find("#registration_link").click
    expect(page).to have_content "Sign Up"
    expect(page).to have_button "Sign Up"
    fill_in "Email", with: 'user@example.com'
    fill_in "Password", with: 'password'
    fill_in "Password Confirmation", with: 'pwd'
    click_button 'Sign Up'
    expect(page).to have_content "Password Confirmation doesn't match Password"
    expect(page).to have_button "Sign Up"
  end

  

end