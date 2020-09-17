 require 'rails_helper'

RSpec.describe "/reminders", type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    {
      title: 'My title',
      description: 'My Description',
      month_day: 3,
      'time_object(4i)': 22,
      'time_object(5i)': 15,
      timezone: 'America/Sao_Paulo'
    }
  end

  let(:invalid_attributes) { { title: '' } }

  let(:reminder) { create(:reminder, user: user) }

  let(:authenticated_user) { user }

  before do
    session_stub = instance_double(SessionManager)
    allow(session_stub).to receive(:authenticated_user).and_return(authenticated_user)
    allow(SessionManager).to receive(:new).and_return(session_stub)\
  end

  describe "GET /index" do
    it "renders a successful response" do
      create(:reminder, user: user)
      get reminders_url
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_reminder_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_reminder_url(reminder)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Reminder" do
        expect {
          post reminders_url, params: { reminder: valid_attributes }
        }.to change(Reminder, :count).by(1)
      end

      it "redirects to the created reminder" do
        post reminders_url, params: { reminder: valid_attributes }
        expect(response).to redirect_to(reminders_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Reminder" do
        expect {
          post reminders_url, params: { reminder: invalid_attributes }
        }.to change(Reminder, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post reminders_url, params: { reminder: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          title: 'My updated title',
          description: 'My updated Description',
          month_day: -5,
          'time_object(4i)': 15,
          'time_object(5i)': 45,
          timezone: 'Europe/Berlin'
        }
      }

      it "updates the requested reminder" do
        patch reminder_url(reminder), params: { reminder: new_attributes }
        expect(reminder.reload).to have_attributes(
          title: 'My updated title',
          description: 'My updated Description',
          month_day: -5,
          time: (15.hours + 45.minutes).to_i,
          timezone: 'Europe/Berlin'
        )
      end

      it "redirects to the reminder" do
        patch reminder_url(reminder), params: { reminder: new_attributes }
        expect(response).to redirect_to(reminders_url)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch reminder_url(reminder), params: { reminder: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested reminder" do
      reminder
      expect {
        delete reminder_url(reminder)
      }.to change(Reminder, :count).by(-1)
    end

    it "redirects to the reminders list" do
      delete reminder_url(reminder)
      expect(response).to redirect_to(reminders_url)
    end
  end
end
