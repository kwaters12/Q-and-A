require 'spec_helper'

describe Api::V1::QuestionsController do
  render_views

  let(:api_key)     { create(:api_key)}
  let!(:question_1) { create(:question)}
  let!(:question_2) { create(:question)}

  before do
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
  end

  describe "fetching all questions" do

    before do
      get :index, {format: :json}
    end

    it {expect(response).to be_success}
    it {expect(response.body).to include(question_1.topic) }
    it {expect(response.body).to include(question_2.topic) }
    it {expect(response.body).to include(question_1.body) }
    it {expect(response.body).to include(question_2.body) }

  end

  describe "fetching single question" do
    let(:question) { create(:question)}

    before do
      get :show, id: question.id, format: :json
    end

    it "includes question topic" do
      body_json = JSON.parse(response.body)
      expect(body_json["topic"]).to eq(question.topic)
    end
  end

  describe "creating a question" do  
    before do
      post :create, question: { topic: 'bacon recipes', body: 'bacon and eggs?'}, format: :json
    end

    it "adds a question to json file" do
      body_json = JSON.parse(response.body)
      expect(body_json).to have_content('bacon recipes')
    end   
  end

  describe "updating a question" do

  end
end