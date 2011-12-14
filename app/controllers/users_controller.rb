class UsersController < ApplicationController
  before_filter :require_user
  # GET /users
  # GET /users.xml
  def index
    if current_user.role == "su"
      @organizations = Organization.all
    elsif current_user.role == "ru"
      @organizations = Organization.find_by_sql("select * from organizations where id in (select organization_id from org_users where user_id = #{current_user.id}) ")
    elsif current_user.role == "sub"
      @projects = Project.find_by_sql("select * for projects where id in (select project_id from user_project where user_id = '#{current_user.id}')")
    end  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def project_user_in_org
   
    @projects = Project.find_by_sql("select * from projects where id in(select project_id from org_projects where organization_id = #{ params[:id] })")
    @users = User.find_by_sql("select * from users where id in(select user_id from org_users where organization_id = #{ params[:id] })")
    @organizations = Organization.find(params[:id])
    respond_to do |format|
      format.js 
    end
  end
  
  def showdiv
    v = params[:value]
    debugger
    respond_to do |f|
      f.js
    end
  end
  
end
