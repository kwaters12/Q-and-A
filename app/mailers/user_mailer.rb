class UserMailer < ActionMailer::Base
  default from: "noreply@mydomain.com"

  def thank_you(question)    
    @topic = question.topic
    @body = question.body
    mail(to: question.user.email)
  end
end
