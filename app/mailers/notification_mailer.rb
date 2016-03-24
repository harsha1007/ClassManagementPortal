class NotificationMailer < ApplicationMailer
	default from: 'admin@ncsu.edu'

	def course_active_email(user_emails, course)
		@users = users
		@course = course
		@user_emails.each do |user|
			mail(to: user.email, subject: "#{@course.title} is now available")
		end
		return @users, @course
	end

end
