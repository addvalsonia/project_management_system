class OrganizationsController < ApplicationController
  # GET /organizations
  # GET /organizations.xml
  def index
    @organizations = Organization.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @organizations }
    end
  end

  # GET /organizations/1
  # GET /organizations/1.xml
  def show
    @organization = Organization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /organizations/new
  # GET /organizations/new.xml
  def new
    
    @organization = Organization.new
    @user = User.find_by_sql("select id,first_name from users where role = 'ru'")
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @organization }
      format.js
    end
  end

  # GET /organizations/1/edit
  def edit
    @organization = Organization.find(params[:id])
  end

  # POST /organizations
  # POST /organizations.xml
  def create
    debugger
    if params[:user_id] == ""
      @organization = Organization.new(params[:organization])
    else
      @organization = Organization.new(params[:organization])
      @organization.assign = 1
    end
    
    respond_to do |format|@user
      if @organization.save
        flash[:notice] = 'Organization was successfully created.'
        
        @org_user = OrgUser.new(:organization_id => @organization.id, :user_id => params[:user_id])
        @org_user.save
        format.html { redirect_to(users_url) }
        format.xml  { render :xml => @organization, :status => :created, :location => @organization }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /organizations/1
  # PUT /organizations/1.xml
  def update
    @organization = Organization.find(params[:id])

    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        flash[:notice] = 'Organization was successfully updated.'
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.xml
  def destroy
    @organization = Organization.find(params[:id])

    respond_to do |format|
      if @organization.destroy
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      end
    end
  end
end
