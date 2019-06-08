class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6}

  before_save { email.downcase! }
  has_secure_password
end
