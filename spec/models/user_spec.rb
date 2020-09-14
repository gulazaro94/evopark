RSpec.describe(User) do
  describe('validations') do
    it('validates email format') do
      user = described_class.new(email: 'invalid_email')

      expect(user).to be_invalid
      expect(user.errors[:email]).to eq(['is invalid'])
    end

    it('requires the password') do
      user = described_class.new(password: '')

      expect(user).to be_invalid
      expect(user.errors[:password]).to eq(["can't be blank"])
    end
  end
end
