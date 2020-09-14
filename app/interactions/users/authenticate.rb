module Users
  class Authenticate < ApplicationInteraction

    string :email
    string :password

    def execute
      user = User.find_by(email: email)
      return errors.add(:email, :invalid) unless user

      user = user.authenticate(password)
      return errors.add(:password, :invalid) unless user

      user
    end

  end
end
