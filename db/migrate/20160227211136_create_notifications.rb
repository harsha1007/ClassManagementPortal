class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :course_id
      t.string :status

      t.timestamps null: false
    end
  end
end
