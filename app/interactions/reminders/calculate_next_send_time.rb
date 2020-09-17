
module Reminders
  class CalculateNextSendTime < ApplicationInteraction

    record(:reminder)

    def execute
      ref_time = Time.use_zone(reminder.timezone) { Time.zone.now }
      time = calculate_send_time(ref_time)
      # calculates sent time for next month if time is in the past
      time = calculate_send_time(ref_time + 1.month) if time < Time.zone.now
      time
    end

    def calculate_send_time(ref_time)
      time =
        if reminder.month_day.positive?
          # First N days of the month
          ref_time.beginning_of_month + (reminder.month_day - 1).days
        else
          # Last N days of the month
          ref_time.end_of_month + (reminder.month_day + 1).days
        end
      # Set the time
      time.beginning_of_day + reminder.time.seconds
    end

  end
end
