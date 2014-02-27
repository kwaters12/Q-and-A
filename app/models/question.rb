class Question < ActiveRecord::Base
  extend FriendlyId
  friendly_id :topic, use: :slugged

  # validates_presence_of :topic, :body 
  validates  :topic, presence: true, length: { maximum: 35 }
  validates  :body,  presence: true

  belongs_to :user
  has_many   :answers
  has_many   :comments, as: :commentable

  def self.total
    total = Question.count
  end

  # def to_param
  #   "#{id} #{topic}".parameterize
  # end
end
