RSpec.describe(Reminders::ScheduleNextSend) do
  let(:reminder) { create(:reminder, month_day: 3, time: reminder_time, timezone: timezone) }
  let(:reminder_time) { (16.hours + 20.minutes).to_i }
  let(:timezone) { 'Europe/Berlin' }
  let(:travel_to_time) { Time.use_zone(timezone) { Time.zone.parse('2020-02-14 16:30') } }

  around do |example|
    Timecop.travel(travel_to_time) do
      example.run
    end
  end

  it('schedules the job and updates the last_job_id') do
    described_class.run(reminder: reminder)

    expect(SendReminderJob).to have_been_enqueued.exactly(:once).with(reminder.id).at(Time.zone.parse('2020-03-03T15:20:00Z'))
    expect(reminder.reload.last_job_id).to be_present
  end

end
