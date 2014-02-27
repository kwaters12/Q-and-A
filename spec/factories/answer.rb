FactoryGirl.define do 
  factory :answer do    
    association :user,     :factory => :user
    association :question, :factory => :question
    body Faker::Company.catch_phrase
  end 
end

