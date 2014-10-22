# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  address         :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean
#

class User < ActiveRecord::Base
  attr_accessible :address, :email, :name, :password, :password_confirmation
  has_secure_password
  has_many :orders, dependent: :destroy

  before_save :create_remember_token

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with:VALID_EMAIL_REGEX }
  validates :address, presence: true, length: { maximum: 30, minimum: 5 }
  validates :password, length: { minimum:6 }

  private
    def create_remember_token
      begin
        token = generate_random_token
        puts token
      end while User.find_by_remember_token(token)
      self.remember_token = token
    end

    def generate_random_token
      SecureRandom.urlsafe_base64
    end
end
