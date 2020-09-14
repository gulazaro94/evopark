RSpec.describe(SessionManager) do
  subject(:session_manager) { described_class.new(session_stub) }
  let(:session_stub) { instance_double('session') }

  let(:user) { create(:user) }

  describe('#authenticate') do
    before do
      allow(session_stub).to receive(:[]=)
    end

    it('stores the user_id in the session') do
      session_manager.authenticate(user)

      expect(session_stub).to have_received(:[]=).with(:user_id, user.id)
    end
  end

  describe('#unauthenticate') do
    before do
      allow(session_stub).to receive(:delete)
    end

    it('deletes the user_id from the session') do
      session_manager.unauthenticate

      expect(session_stub).to have_received(:delete).with(:user_id)
    end
  end

  describe('#authenticated_user') do
    before do
      allow(session_stub).to receive(:[]).with(:user_id).and_return(user.id)
    end

    it('returns the authenticated user') do
      expect(session_manager.authenticated_user).to eq(user)
    end
  end
end
