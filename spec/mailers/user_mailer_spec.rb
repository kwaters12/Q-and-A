require 'spec_helper'

describe UserMailer do 
  let(:user)     {create :user}
  let(:question) {create :question, user: user}
  it "sends to the creator of the question" do
    email = UserMailer.thank_you(question)
    expect(email.to).to have_content(question.user.email)
  end  
end