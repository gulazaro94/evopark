module Reminders
  class Create < ApplicationInteraction

    record(:user)
    hash(:attributes, strip: false, default: {})

    def to_model
      Reminder.new
    end

    def execute
      reminder = user.reminders.new(attributes)

      if reminder.save
        Reminders::ScheduleNextSend.run!(reminder: reminder)
      end

      reminder
    end

  end
end
