class Answer < ActiveRecord::Base
  extend FriendlyId
  friendly_id :body, use: :slugged
  
  belongs_to :question, touch: true
  belongs_to :user
  

  has_many   :comments, as: :commentable

end
