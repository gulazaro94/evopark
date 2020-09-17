class ReminderMailer < ApplicationMailer

  def send_reminder
    reminder = params[:reminder]

    mail(
      to: reminder.user.email,
      subject: reminder.title,
      body: reminder.description,
      content_type: "text/html"
    )
  end


end
