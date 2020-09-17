module Reminders
  class ScheduleNextSend < ApplicationInteraction

    record(:reminder)

    def execute
      next_send_time = Reminders::CalculateNextSendTime.run!(reminder: reminder)

      job = SendReminderJob.set(wait_until: next_send_time).perform_later(reminder.id)
      reminder.update_attribute(:last_job_id, job.job_id)
    end

  end
end
