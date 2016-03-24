class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    changeStatus
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
    @users = User.find_by_sql("select * from users where usertype = 'Instructor'")
  end

  # GET /courses/1/edit
  def edit
    @users = User.find_by_sql("select * from users where usertype = 'Instructor'")
  end

  def inactive_requests
    @course = Course.find_by_id(params[:id])
    @course.inactive_request = 'Yes'
    if @course.save
      render plain: "Request has been sent to admins to make #{@course.title} inactive."
    else
      render plain: "Request has failed."
    end
  end

  def inactive_requests_admin
    @courses = Course.find_by_sql("select * from courses where inactive_request = 'Yes'")
  end

  def students
    @course = Course.find_by_id(params[:id])
    @accepted_students = @course.course_mappings.select {|student| student.decision == 'Accepted'}.map {|student| student.user_id}
    @students = @course.users.select {|user| @accepted_students.include?(user.id)}
    return @students, @course
  end

  def search
    changeStatus
    search_course = params[:course].reject {|key, value| value.empty?}
    if search_course.values.empty?
      redirect_to '/courses'
    else
      sql_query = "select * from courses where "
      i = 1
      #Formation of SQL Query to show matching users to the search criteria.
      search_course.each do |key, value|
        if key != 'status'
          sql_query = sql_query + "lower(#{key}) LIKE lower('%#{value}%')"
        else
          sql_query = sql_query + "lower(#{key}) = lower('#{value}')"
        end
        if(i < search_course.length)
          sql_query = sql_query + " AND "
          i += 1
        end
      end
      @courses = Course.find_by_sql(sql_query)
    end
  end

  # POST /courses
  # POST /courses.json
  def create   
    @users = User.find_by_sql("select * from users where usertype = 'Instructor'")

    if params[:course][:instructor] != nil
      @user = User.find_by_id(params[:course][:instructor])
      params[:course][:instructor] = @user.name
    
      course_attrs = params.require(:course).permit(:title, :description, :instructor, :start_date, :end_date, :status, :course_number)
      @course = Course.new(course_attrs)

      @user.course_mappings.create(course: @course)

    else
      @course = Course.new(course_params)
    end  

    respond_to do |format|
      if@course.save
         format.html { redirect_to @course, notice: 'Course was successfully updated.' }
         format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    @users = User.find_by_sql("select * from users where usertype = 'Instructor'")

    if params[:course][:instructor] != nil
         
      @user = User.find_by_id(params[:course][:instructor])
      params[:course][:instructor] = @user.name
    
      course_attrs = params.require(:course).permit(:title, :description, :instructor, :start_date, :end_date, :status, :course_number)

      @old_course = Course.find_by_id(@course.id)
      @old_instructor_name = @old_course.instructor
      @old_instructor_id = User.find_by_name(@old_instructor_name).id

      if @old_instructor_id != params[:course][:instructor]
        CourseMapping.where(user_id: @old_instructor_id, course_id: @course.id).destroy_all
        @user.course_mappings.create(course: @course)
      end

      if @course.status == 'Inactive'
        @course.inactive_request = 'No'
      end

      if @old_course.status == 'Inactive' and params[:course][:status] == 'Active'
        @user_ids = Notification.find_by_sql("select user_email from notifications where course_id = #{@course.id}")
        @user_emails = @user_ids.map {|notification| notification.user_email}
        NotificationMailer.course_active_email(@user_emails, @course)
      end 

      respond_to do |format|
        if @course.update(course_attrs)
          format.html { redirect_to @course, notice: 'Course was successfully updated.' }
          format.json { render :show, status: :ok, location: @course }
        else
          format.html { render :edit }
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end    

    else
      respond_to do |format|
        if @course.update(course_params)
          format.html { redirect_to @course, notice: 'Course was successfully updated.' }
          format.json { render :show, status: :ok, location: @course }
        else
          format.html { render :edit }
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:title, :description, :instructor, :start_date, :end_date, :status, :course_number)
    end
end
