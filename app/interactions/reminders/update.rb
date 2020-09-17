module Reminders
  class Update < ApplicationInteraction

    record(:reminder)
    hash(:attributes, strip: false)

    def execute
      if reminder.update(attributes)
        Reminders::ScheduleNextSend.run!(reminder: reminder)
      end

      reminder
    end

  end
end
