class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.string :title
      t.text :description
      t.integer :month_day, limit: 1
      t.integer :time, limit: 3
      t.string :timezone

      t.timestamps
      t.index %i[user_id created_at]
    end
  end
end
