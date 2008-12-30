class TransformationsController < ApplicationController
  before_filter :find_item, :only => [ :new, :create ]
  #after_filter :store_location, :only => [:new]
  
  # GET /transformations
  # GET /transformations.xml
  # def index
  #   @transformations = Transformation.find(:all)
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @transformations }
  #   end
  # end

  # GET /transformations/1
  # GET /transformations/1.xml
  # def show
  #   @transformation = Transformation.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @transformation }
  #   end
  # end

  # GET /transformations/new
  # GET /transformations/new.xml
  def new
    @transformation = Transformation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transformation }
    end
  end

  # GET /transformations/1/edit
  # def edit
  #   @transformation = Transformation.find(params[:id])
  # end

  # POST /transformations
  # POST /transformations.xml
  def create
    @transformation = @item.transformations.build(params[:transformation])

    respond_to do |format|
      if @transformation.save
        flash[:notice] = 'Transformation was successfully created.'
        format.html { redirect_to(@item) }
        format.xml  { render :xml => @transformation, :status => :created, :location => @transformation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @transformation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /transformations/1
  # PUT /transformations/1.xml
  # def update
  #   @transformation = Transformation.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @transformation.update_attributes(params[:transformation])
  #       flash[:notice] = 'Transformation was successfully updated.'
  #       format.html { redirect_to(@transformation) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @transformation.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /transformations/1
  # DELETE /transformations/1.xml
  # def destroy
  #   @transformation = Transformation.find(params[:id])
  #   @transformation.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(transformations_url) }
  #     format.xml  { head :ok }
  #   end
  # end
  
  private
  
    def find_item
      @item = Item.find(params[:item_id])
    end
end
