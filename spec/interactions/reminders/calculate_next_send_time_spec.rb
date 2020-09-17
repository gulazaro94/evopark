RSpec.describe(Reminders::CalculateNextSendTime) do
  let(:reminder) { create(:reminder, month_day: month_day, time: reminder_time, timezone: timezone) }
  let(:reminder_time) { (16.hours + 20.minutes).to_i }
  let(:timezone) { 'Europe/Berlin' }
  let(:travel_to_time) { Time.use_zone(timezone) { Time.zone.parse('2020-02-14 16:30') } }

  around do |example|
    Timecop.travel(travel_to_time) do
      example.run
    end
  end

  shared_examples('calculates the next send time') do
    it('calculates the correct time') do
      next_send_time = described_class.run!(reminder: reminder)
      expect(next_send_time).to eq(expected_send_time)
    end
  end

  context('when month day is positive and before current day') do
    let(:month_day) { 3 }
    let(:expected_send_time) { Time.use_zone(timezone) { Time.zone.parse('2020-03-03 16:20') } }

    include_examples('calculates the next send time')
  end

  context('when month day is positive and after current day') do
    let(:month_day) { 14 }
    let(:reminder_time) { (16.hours + 40.minutes).to_i }
    let(:expected_send_time) { Time.use_zone(timezone) { Time.zone.parse('2020-02-14 16:40') } }

    include_examples('calculates the next send time')
  end


  context('when month day is negative and after current day') do
    let(:month_day) { -5 }
    let(:expected_send_time) { Time.use_zone(timezone) { Time.zone.parse('2020-02-25 16:20') } }

    include_examples('calculates the next send time')
  end

  context('when month day is negative and before current day') do
    let(:month_day) { -16 }
    let(:reminder_time) { (16.hours + 40.minutes).to_i }
    let(:expected_send_time) { Time.use_zone(timezone) { Time.zone.parse('2020-02-14 16:40') } }

    include_examples('calculates the next send time')
  end
end
