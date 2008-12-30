class ReferencesController < ApplicationController
  before_filter :find_item, :only => [ :new, :create ]
  after_filter :store_location, :only => [:index, :new, :edit]
  
  # GET /references
  # GET /references.xml
  def index
    @references = Reference.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @references }
    end
  end

  # GET /references/1
  # GET /references/1.xml
  # def show
  #   @reference = Reference.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @reference }
  #   end
  # end

  # GET /references/new
  # GET /references/new.xml
  def new
    @reference = Reference.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reference }
    end
  end

  # GET /references/1/edit
  def edit
    @reference = Reference.find(params[:id])
  end

  # POST /references
  # POST /references.xml
  def create
    @reference = @item.references.build(params[:reference])

    respond_to do |format|
      if @reference.save
        flash[:notice] = 'Reference was successfully created.'
        format.html { redirect_to(@item) }
        format.xml  { render :xml => @reference, :status => :created, :location => @reference }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reference.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /references/1
  # PUT /references/1.xml
  def update
    @reference = Reference.find(params[:id])

    respond_to do |format|
      if @reference.update_attributes(params[:reference])
        flash[:notice] = 'Reference was successfully updated.'
        format.html { redirect_to(references_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reference.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /references/1
  # DELETE /references/1.xml
  def destroy
    @reference = Reference.find(params[:id])
    @reference.destroy

    respond_to do |format|
      format.html { redirect_to(references_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
    def find_item
      @item = Item.find(params[:item_id])
    end
end
