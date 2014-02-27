require 'spec_helper'

feature 'Questions' do
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end
   
  scenario "A user fails to fill out the question form" do
    visit "/"
    click_on "Ask A Question"
    fill_in "Topic", with: " "
    fill_in "Question", with: " "
    click_on "Ask"
    expect(page).to have_selector('.alert-danger')
    visit "/"
    expect(page).not_to have_selector('.alert-danger')
  end

  scenario "A user provides invalid input and dismisses the message", js: true do
    visit new_question_path
    click_on "Ask"
    click_on "×"
    expect(page).not_to have_selector('.alert-danger')
  end
end
