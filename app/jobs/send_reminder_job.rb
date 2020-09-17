class SendReminderJob < ApplicationJob
  queue_as :default

  sidekiq_options retry: 2, backtrace: 20

  def perform(reminder_id)
    reminder = Reminder.find_by(id: reminder_id)
    return unless reminder
    return if job_id != reminder.last_job_id

    Reminders::SendReminder.run!(reminder: reminder)
    Reminders::ScheduleNextSend.run!(reminder: reminder)
  end
end
