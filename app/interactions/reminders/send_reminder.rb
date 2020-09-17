module Reminders
  class SendReminder < ApplicationInteraction

    record(:reminder)

    def execute
      ReminderMailer.with(reminder: reminder).send_reminder.deliver_now
    end

  end
end
