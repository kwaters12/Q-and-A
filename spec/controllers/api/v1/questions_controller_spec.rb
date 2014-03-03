require 'spec_helper'

describe Api::V1::QuestionsController do

  let!(:question_1) { create(:question)}
  let!(:question_2) { create(:question)}

  it "responds successfully" do
    get :index, {format: :json}
    expect(response).to be_success
  end

  it "returns question information" do
    get :index, {format: :json}
    expect(response.body).to include(question_1.topic) 
  end
end