FactoryGirl.define do 
  factory :question do    
    association :user, :factory => :user
    # make it unique
    sequence(:topic){ |n| "#{Faker::Company.name} #{n}"[0..34]}
    # title Faker::Lorem.sentence
    body Faker::Company.bs
  end 

  factory :invalid_question, parent: :question do
    title ""
  end
end

