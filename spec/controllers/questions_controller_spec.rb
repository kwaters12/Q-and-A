require 'spec_helper'

describe QuestionsController do

 include Devise::TestHelpers

 let(:question) { create(:question) }

  before (:each) do
    user = create(:user)
    sign_in user
  end
  before { ActionMailer::Base.deliveries = [] } #  ActionMailer::Base.deliveries.clear

  describe "#index" do
    it "is successful" do
      get :index
      expect(response).to be_success
    end
  end

  describe "#create" do    

    it "creates a new question" do
      expect do
        post :create, question: { topic: 'bacon recipes', body: 'bacon and eggs?'}
      end.to change {Question.count}.by(1)
    end 

    it "redirects to the homepage" do
      post :create, question: { topic: 'bacon recipes', body: 'bacon and eggs?'}
      expect(response).to redirect_to(root_url)
    end

    it "sets a thank you method in flash" do
      post :create, question: { topic: 'bacon recipes', body: 'bacon and eggs?'}
      expect(flash[:notice]).to be
    end

    it "sends a thank you email" do
      post :create, question: { topic: 'bacon recipes', body: 'bacon and eggs?'}
      expect(ActionMailer::Base.deliveries).to have(1).item
    end

    it "sets a flash message indicating an error" do
      post :create, question: {topic: '', body: ''}
      expect(flash[:error]).to be
    end
  end

  describe "#show" do
    it "shows the question" do
      question = create :question, topic: 'bacon recipes', body: 'bacon and eggs?'
      get :show, id: question.id
      expect(response).to be_success
    end
  end

  describe "#edit" do

    it "updates the band information" do
      put :update, id: question, question: { body: question.body }
      question.body = "New Body"
      expect(question.body).to eq("New Body")
    end
   
    # it "allows a question to be updated" do
    #   question = create :question, topic: 'bacon recipes', body: 'bacon and eggs?'
    #   get :edit, id: question.id
    #   put :update, id: question.id, topic: 'baacon', body: 'noope'
    #   expect(response).to have_content('baacon')
    # end

    it "responds to PUT" do
      question = create :question, topic: 'bacon recipes', body: 'bacon and eggs?'
      patch :update, id: question.id, question: {topic: 'beecon', body: 'boocon'}
      expect(response).to redirect_to(question_url)
    end
  end

  
end