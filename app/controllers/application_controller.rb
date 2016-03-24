class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :is_logged_in

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def is_logged_in
  	unless current_user
  		flash[:notice] = 'Please login to proceed further'
  		redirect_to '/'
  	end
  end

  def admin_logged_in
    unless (current_user && current_user.usertype == 'Admin' or current_user.usertype == 'Super Admin')
      flash[:notice] = 'Only admins can view this page.'
      redirect_to '/'
    end
  end

  def changeStatus
    @courses = Course.find_by_sql("select * from courses where status = 'Active'")
    @courses.each do |course|
      if course.end_date < DateTime.now
        course.status = 'Inactive'
        course.save
      end  
    end
  end
  
end
