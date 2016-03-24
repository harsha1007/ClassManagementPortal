class ChangeNotificationUserColumn < ActiveRecord::Migration
  def change
  	change_column :notifications, :user_id, :string
  	rename_column :notifications, :user_id, :user_email
  end
end
