class ItemsController < ApplicationController
  before_filter :prune_params, :only => [:create]
  before_filter :find_category, :only => [:index]
  after_filter :store_location, :only => [:index, :new, :show, :edit]
  
  # GET /items
  # GET /items.xml
  def index
    @items = @category.blank? ? Item.roots : @category.items

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.factory('local')
        
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    # The item is either "Local" or "Remote" depending on the source selected
    @item = Item.factory(params[:source], params[@hash_key.to_sym])
    
    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to(item_url(@item)) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[@item.class.to_s.downcase.to_sym])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(@item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
  
  def search
    @items = Item.search(params[:query])
    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @items.to_xml }
    end
  end
  
  private
  
    def find_category
      @category = Category.find(params[:category_id]) if params[:category_id]
    end
  
    def prune_params
      @hash_key = 'item' if params.has_key?("item")
      @hash_key = 'local' if params.has_key?("local")
      @hash_key = 'remote' if params.has_key?("remote")
      
      remove_attrs = "local" if params[:source] == "remote"
      remove_attrs = "remote" if params[:source] == "local"
      
      # Remove unnecessary keys from the item hash depending on the source.
      params[@hash_key.to_sym].delete_if { |key, value| key.start_with?(remove_attrs) }
    end
end
