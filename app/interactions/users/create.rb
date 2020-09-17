module Users
  class Create < ApplicationInteraction

    string :email
    string :password

    def execute
      user = User.new(inputs)
      user.save
      user
    end

  end
end
