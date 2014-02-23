require 'spec_helper'

feature 'Question' do 
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    user = create(:user)
    login_as(user, :scope => :user)
  end

  scenario "When the user visits the homepage" do
    visit "/"
    expect(page).to have_content("Ask")
  end

  scenario "User can add a question" do
    visit "/"
    click_on "Ask A Question"
    fill_in "Topic", with: "bacon recipes"
    fill_in "Question", with: "bacon and eggs?"
    click_on "Ask"
    expect(current_path).to eq("/")
    # expect(ActionMailer::Base.deliveries).to have(1).item
  end

  scenario "User can see all questions that have been asked" do
    #Given
    create :question, topic: "bacon recipes", body: "bacon and eggs?"

    #When
    visit "/"

    #Then
    expect(page).to have_content("Topic: bacon recipes")
  end  

  scenario "When user clicks on a question, they go to the #show page for that question" do
    visit "/"
    question = create :question, topic: "bacon recipes", body: "bacon and eggs?"
    visit(question_path(question.id))
    expect(page).to have_content("Topic: bacon recipes")
  end

  scenario "Users can only create questions of they are logged in" do
    visit "/"
    user = create(:user)
    login_as(user, :scope => :user)
    click_on "Sign Out"
    click_on "Ask A Question"
    expect(page).to have_content("Sign in")
  end

  scenario "User can edit questions" do
    visit "/"
    question = create :question, topic: "bacon recipes", body: "bacon and eggs?"
    visit(edit_question_path(question.id))
    fill_in "Topic", with: "vegan tacoes"
    fill_in "Question", with: "why?"
    click_on "Ask"
    expect(page).to have_content("vegan tacoes")
  end

  # scenario "User can delete questions" do
  #   visit "/"
  #   question = create :question, topic: "bacon recipes", body: "bacon and eggs?"
  #   visit(destroy_question_path(question.id))
  #   visit "/"
  #   expect(page).not_to have_content("bacon recipes")
  # end

  scenario "Users can see form for adding answers on the homepage" do
    create :question, topic: "bacon recipes", body: "bacon and eggs?"
    visit "/"
    expect(page).to have_content("Answers:")
  end

  scenario "User can see all answers for each question" do
    question = create :question, topic: "bacon recipes", body: "bacon and eggs?"
    visit "/"
    visit(question_path(question.id))
    fill_in "Enter New Answer", with: "sure"
    click_on "Create Answer"
    visit "/"
    expect(page).to have_content("sure")

  end

  # scenario "Users can see a form to add answers on each question" do
  #   create :question, topic: "bacon recipes", body: "bacon and eggs?"
  #   visit "/"
  #   expect(page).to have_content("submit")
  # end


end