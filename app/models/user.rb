class User < ApplicationRecord
  has_secure_password

  has_many(:reminders)

  validates(:email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true)
end
