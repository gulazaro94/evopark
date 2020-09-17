class AddLastJobIdToReminders < ActiveRecord::Migration[6.0]
  def change
    add_column :reminders, :last_job_id, :string, null: true
  end
end
