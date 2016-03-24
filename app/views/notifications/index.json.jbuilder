json.array!(@notifications) do |notification|
  json.extract! notification, :id, :user_id, :course_id, :status
  json.url notification_url(notification, format: :json)
end
