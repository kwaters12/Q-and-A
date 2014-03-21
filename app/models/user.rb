class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions
  has_many :answers

  has_one :api_key

  before_create :generate_api_key

  def self.find_or_create_from_google(user_info, uid)
    user = User.find_by_email(user_info["email"])

    unless user
    user = User.create( first_name: user_info["first_name"],
                          last_name:  user_info["last_name"],
                          email:      user_info["email"],
                          uid:        uid,
                          provider:   "google_oauth2",
                          password:   Devise.friendly_token)
    end
    user
  end

  def name_display
    if first_name || last_name
      "#{first_name} #{last_name}".strip
    else
      email
    end
  end

  private

  def generate_api_key
    self.api_key = ApiKey.new
  end
end
