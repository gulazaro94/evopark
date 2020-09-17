class RemindersController < ApplicationController
  before_action :set_reminder, only: [:show, :edit, :update, :destroy]

  def index
    @reminders = current_user.reminders.order(created_at: :desc)
  end

  def new
    @reminder = Reminder.new
  end

  def edit
  end

  def create
    @reminder = Reminders::Create.run!(user: current_user, attributes: reminder_params.to_h)
    if @reminder.persisted?
      redirect_to reminders_path, notice: 'Reminder was successfully created.'
    else
      render :new
    end
  end

  def update
    @reminder = Reminders::Update.run!(reminder: @reminder, attributes: reminder_params.to_h)
    if @reminder.errors.blank?
      redirect_to reminders_path, notice: 'Reminder was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @reminder.destroy!

    redirect_to reminders_url, notice: 'Reminder was successfully destroyed.'
  end

  private

  def set_reminder
    @reminder = Reminder.find(params[:id])
  end

  def reminder_params
    params.require(:reminder).permit(:title, :description, :month_day, :timezone, :time_object)
  end

end
