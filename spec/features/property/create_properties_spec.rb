require 'rails_helper'

RSpec.feature "Create Properties", :type => :feature do 
  let!(:user) {create(:user)}
  
  scenario "Visit new property from home page"  do 
  	#We use a method to login to make writing tests faster
  	simulate_sign_in(user)
    visit "/"
  	click_link "Add Property"
    expect(page).to have_field("Description")
  end

  scenario "Visit new property from properties list" do 
    simulate_sign_in(user)
    within("nav") do 
      click_link "Properties"
    end
    expect(page).to have_content("No Properties On File")
    click_link "Add Property"
    expect(page).to have_field("Description")
  end

  scenario "Create Property with pictue", js: true do 
  	simulate_sign_in(user)
    visit root_path
    click_link "Add Property"
    expect(page).to have_button("Save Property")
  	click_button 'Save Property'
  	fill_in "Description", with: "My Property"
  	fill_in "Address", with: "My Address"
  	fill_in "City", with: "Athens"
  	fill_in "State", with: "GA"
  	fill_in "Zip", with: "30606"
    
    page.attach_file("Picture", Rails.root.join('spec','factories','files','home.jpg'))
    
  	click_button 'Save Property'
    
  	expect(page).to have_content "Select Property to Manage"
  	expect(page).to have_content "My Property"
    property = Property.last
    expect(page.find("#property_thumbnail")['src']).to have_content(rails_representation_path(property.thumbnail))
  end

  scenario "Create Property with Valid information", js: true do 
    simulate_sign_in(user)
    visit "/"
    click_link "Add Property"
    expect(page).to have_button("Save Property")
    click_button 'Save Property'
    fill_in "Description", with: "My Property"
    fill_in "Address", with: "My Address"
    fill_in "City", with: "Athens"
    fill_in "State", with: "GA"
    fill_in "Zip", with: "30606"
    
    click_button 'Save Property'
    
    expect(page).to have_content "Select Property to Manage"
    expect(page).to have_content "My Property"
  end

  scenario "Cannot Create Property with Invalid information", js: true do
    simulate_sign_in(user)
    visit new_property_path
    fill_in "Description", with: ""
    fill_in "Address", with: "My Address"
    fill_in "City", with: "Athens"
    fill_in "State", with: "GA"
    fill_in "Zip", with: "30606"
    click_button 'Save Property'
    
    expect(page.find_field("Description").value).to eq("")
    expect(page).to have_content("Error detected trying to save Property")
  end
end
