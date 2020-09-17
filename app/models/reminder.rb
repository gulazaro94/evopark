class Reminder < ApplicationRecord
  belongs_to :user

  VALID_MONTH_DAYS = ((-28..28).to_a - [0]).freeze

  validates(:user, :title, :description, :month_day, :time, :timezone, presence: true)
  validates(:month_day, inclusion: { in: VALID_MONTH_DAYS })

  def time_object=(params)
    hours = params[4].to_i
    minutes = params[5].to_i
    self.time = (hours.hours + minutes.minutes).to_i
  end

  def time_object
    return unless time

    Time.zone.now.beginning_of_day + time
  end
end
