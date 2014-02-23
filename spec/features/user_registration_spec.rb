require 'spec_helper'

feature "User registration" do 
  # Given An anonymous user
  # When They visit the site's homepage
  # Then They can register
  scenario "Successful registration" do
    #Given
    visit "/"
    #When 
    click_on "Register"
    fill_in "First name", with: 'Bob'
    fill_in "Last name", with: 'Smitty'
    fill_in "Email", with: 'bob@example.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_on "Sign up"
    #Then
    expect(page).to have_content("Welcome! You have signed up successfully")
  end

  scenario "Unsuccessful registration" do
    visit "/"
    click_on "Register"
    fill_in "First name", with: 'Bob'
    fill_in "Last name", with: 'Smitty'
    fill_in "Email", with: ''
    fill_in "Password", with: ''
    fill_in "Password confirmation", with: ''
    click_on "Sign up"
    expect(page).to have_content("Email can't be blank")
  end
  
end