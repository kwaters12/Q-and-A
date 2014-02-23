require 'spec_helper'

describe AnswersController do

  let(:user)     { create(:user)                         }
  let(:question) { create(:question)                     }
  let(:answer)   { create(:answer, question: question)   }

 include Devise::TestHelpers

  before (:each) do
    user = create(:user)
    sign_in user
  end
  before { ActionMailer::Base.deliveries = [] } #  ActionMailer::Base.deliveries.clear

  context "Answers for the question" do
    subject { post :create, question_id: question.id }
      it "adds an answer to a question" do
        expect do
        answer = create :answer, body: 'bacon and eggs?'        
        end.to change {Answer.count}.by(1)
      end
  end

end