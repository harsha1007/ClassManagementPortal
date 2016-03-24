  class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :is_logged_in, only: [:new, :create, :login, :main]
  before_action :admin_logged_in, only: [:index, :new_user]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end
  # GET /users/1
  # GET /users/1.json
  def show
    render :layout => false
  end

  def login
    @user = User.find_by(email: params[:user][:email])
    if @user && (@user.password == params[:user][:password])
      session[:user_id] = @user.id
      redirect_to '/'
    else
      flash[:notice] = "Invalid credentials"
      redirect_to '/'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/'
  end

  def search
    search_user = params[:user].reject {|key, value| value.empty? }
    if search_user.values.empty?
      redirect_to '/users'
    else
      sql_query = "select * from users where "
      i = 1
      #Formation of SQL Query to show matching users to the search criteria.
      search_user.each do |key, value|
        sql_query = sql_query + "lower(#{key}) LIKE lower('%#{value}%')"
        if(i < search_user.length)
          sql_query = sql_query + " AND "
          i += 1
        end
      end
      @users = User.find_by_sql(sql_query)
    end
  end

  def new_user
    @user = User.new
  end
  
  # GET /users/new
  def new
    @user = User.new
    render :layout => false
  end


 # GET /users/1/edit
  def edit
    unless params[:id].to_i == current_user.id or current_user.usertype == 'Admin' or current_user.usertype == 'Super Admin'
      flash[:notice] = "You do not have permission to access these details."
      redirect_to '/'
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      if @user.usertype == 'Student'
        redirect_to '/', notice: 'User was successfully created. Login to access home page.'
      else
        redirect_to '/', notice: 'User was successfully created.'
      end
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to '/', notice: 'User was successfully updated.' }
      else
        format.html { redirect_to '/', notice: 'There was a problem updating the user.' }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy 
    if @user.courses.any? {|course| course.status == 'Active'} and @user.usertype == 'Instructor'
      redirect_to '/users', notice: 'This instuctor has a active course(s). Change the instructor for his active course(s) before deleting him.'
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to '/users', notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :usertype)
    end

    def login_parms
      params.require(:user).permit(:email, :password)
    end
end