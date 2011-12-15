class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.xml
  def index
     organization = Organization.find(params[:organization_id])
    @projects = organization.projects.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
    @organization = Organization.find(params[:organization_id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
      format.js
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    
    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        debugger
        @org_project = OrgProject.new(:organization_id => params[:organization_id],:project_id => @project.id)
        @org_project.save
        format.html { redirect_to(users_url) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { render :controller => 'users',:action => 'index' }
      format.xml  { head :ok }
    end
  end
end
