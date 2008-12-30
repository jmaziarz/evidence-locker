class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all, :order => 'name ASC')

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @users.to_xml }
    end
  end
  
  # GET /users/1
  # GET /users/1.xml
  # def show
  #   @user = User.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.rhtml
  #     format.xml  { render :xml => @user.to_xml }
  #   end
  # end
  
  # GET /users/new
  def new
    @user = User.new
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
        format.html { redirect_to users_url }
        format.xml  { head :created, :location => user_url(@user) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors.to_xml }
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
        format.html { redirect_to users_url }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors.to_xml }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.xml  { head :ok }
    end
  end
  
  private
  
    # Override for AuthenticatedSystem#authorized?
    def authorized?
      # Admin should have access to everything
      return true if current_user.admin?
      # Users should only have access to edit and update their own profile
      return true if (%w(edit update).include? params[:action]) && (!current_user.admin?) && (params[:id] == current_user.id.to_s)
    end
    
    # Override for AuthenticatedSystem#access_denied
    def access_denied
      redirect_back_or_default(items_url)
    end
end
