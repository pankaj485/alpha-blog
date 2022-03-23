class User < ApplicationRecord
  before_save { self.email = email.downcase }

  has_many :articles, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 }, format: { with: VALID_EMAIL_REGEX }

  # ruby method to use bcrypt in order to secure password.
  has_secure_password
end
