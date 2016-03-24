class CourseMappingsController < ApplicationController

  # GET /course_mappings
  # GET /course_mappings.json
  def index
    @course_mappings = CourseMapping.all
  end

  # GET /course_mappings/1
  # GET /course_mappings/1.json
  def show
      @course = Course.find(params[:id])
  end

  # GET /course_mappings/new
  def new
    @course_mapping = CourseMapping.new
  end

  # GET /course_mappings/1/edit
  def edit
    @course_mapping = CourseMapping.find(params[:id])
  end

  def requests
    @course = Course.find(params[:id])
    @requests = @course.course_mappings
    @request_users = @requests.select{|request| request.decision == "Requested"}.map{|request| request.user_id}
    @users = @course.users.select{|user| @request_users.include?(user.id)}
    return @users, @course
  end

  def accept
    @course_mapping = CourseMapping.find_by_user_id_and_course_id(params[:user], params[:course])
    @course_mapping.decision = "Accepted"
    if @course_mapping.save
      flash[:notice] = "Student is accepted."
      redirect_to :back
    else  
      render plain: "There were errors while saving the record"
    end
  end

  def reject
    @course_mapping = CourseMapping.find_by_user_id_and_course_id(params[:user], params[:course])
    @course_mapping.decision = "Rejected"
    if @course_mapping.save
      flash[:notice] = "Student is rejected."
      redirect_to :back
    else  
      render plain: "There were errors while saving the record"
    end
  end

  def enroll
    @course = Course.find(params[:id])
    if @current_user.courses.include?(@course)
      flash[:notice] = "You have already sent an enrollment request for this course. Check 'My Courses' page for status."
    else  
      @current_user.course_mappings.create(course: @course, decision: "Requested" )
      flash[:notice] = "Request for enrollment in the course is sent to the instructor."
    end
    redirect_to :back
  end

  def remove
    @course_mapping = CourseMapping.find_by_user_id_and_course_id(params[:user], params[:course])
    @course_mapping.decision = "Removed"
    if @course_mapping.save
      flash[:notice] = "Student is removed from the course."
      redirect_to :back
    else  
      render plain: "There were errors while saving the record"
    end
  end

  def grades
    @course_mapping = CourseMapping.find_by_user_id_and_course_id(params[:course_mapping][:user_id], params[:course_mapping][:course_id])
    @course_mapping.grade = params[:course_mapping][:grade]
    if @course_mapping.save
      flash[:notice] = "Grade is posted for the student"
      redirect_to :back
    else  
      render plain: "There were errors while saving the record"
    end
  end

  def user_history
    changeStatus
    @user = User.find_by_id(params[:id])
    @courses = @user.courses.sort_by &:id
    @course_mappings = @user.course_mappings.sort_by &:course_id
    return @courses, @course_mappings, @user
  end  
  
  def my_courses
    changeStatus
    @courses = @current_user.courses.sort_by &:id
    @course_mappings = @current_user.course_mappings.sort_by &:course_id
    return @courses, @course_mappings
  end
  # POST /course_mappings
  # POST /course_mappings.json
  def create
    @course_mapping = CourseMapping.new(course_mapping_params)

    respond_to do |format|
      if @course_mapping.save
        format.html { redirect_to @course_mapping, notice: 'Course mapping was successfully created.' }
        format.json { render :show, status: :created, location: @course_mapping }
      else
        format.html { render :new }
        format.json { render json: @course_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_mappings/1
  # PATCH/PUT /course_mappings/1.json
  def update
    @course_mapping = CourseMapping.find(params[:id])
    respond_to do |format|
      if @course_mapping.update(course_mapping_params)
        format.html { redirect_to @course_mapping, notice: 'Course mapping was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_mapping }
      else
        format.html { render :edit }
        format.json { render json: @course_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_mappings/1
  # DELETE /course_mappings/1.json
  def destroy
    @course_mapping = CourseMapping.find(params[:id])
    @course_mapping.destroy
    respond_to do |format|
      format.html { redirect_to course_mappings_url, notice: 'Course mapping was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def course_mapping_params
      params.require(:course_mapping).permit(:course_id, :user_id, :decision, :grade)
    end
end
