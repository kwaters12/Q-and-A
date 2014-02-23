require 'spec_helper'

feature 'Question Page' do 
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    user = create(:user)
    login_as(user, :scope => :user)
  end  

  scenario "shows a form for user to answer the question" do
    visit "/"    
    question = create :question, topic: 'bacon recipes', body: 'bacon and eggs?'
    visit(question_path(question.id))
    expect(page).to have_content("Answers:")
  end

  scenario "Showing all of the answers to the question" do
    visit "/"       
    question = create :question, topic: "bacon recipes", body: "bacon and eggs?"    
    visit(question_path(question.id))
    create :answer, body: 'bacon and eggs?'    
    puts Answer.count   
    expect(page).to have_content('bacon')
  end

  
end