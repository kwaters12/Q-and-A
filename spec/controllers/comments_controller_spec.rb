require 'spec_helper'

describe CommentsController do
  let(:question) {create(:question)}

  describe "GET 'index'" do
    it "returns http success" do
      get :index, question_id: question.id
      expect(response).to be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new, question_id: question.id
      expect(response).to be_success
    end
  end

end
