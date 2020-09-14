RSpec.describe(Users::Authenticate) do
  let(:user) { create(:user) }

  it('returns the user with correct creds') do
    result = described_class.run!(email: user.email, password: '123123')

    expect(result).to eq(user)
  end

  it('fails when email is wrong') do
    outcome = described_class.run(email: 'wrongemail@email.com', password: '123123')

    expect(outcome).to be_invalid
    expect(outcome.errors[:email]).to eq(['is invalid'])
  end

  it('fails when password is wrong') do
    outcome = described_class.run(email: user.email, password: 'aaabbb')

    expect(outcome).to be_invalid
    expect(outcome.errors[:password]).to eq(['is invalid'])
  end
end
