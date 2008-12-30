class Local < Item
  ## Callbacks
  after_create :generate_hash
  after_create :unpack_in_background, :if => :local_unpack
  
  ## Plugins
  # Paperclip interpolations are defined in config/initializers/paperclip.rb
  has_attached_file :local, :url => "/#{File.basename(DATA_PATH)}/:identifier/:basename.:extension", :path => "#{DATA_PATH}/:identifier/:basename.:extension"
  
  ## Validations
  validates_attachment_presence :local

  private
  
    ## Callback methods
  
    def unpack_in_background
      logger.info "Submitting background job(s) for item #{self.identifier}"
      Bj.submit("./script/runner ./lib/jobs/local_unpack.rb #{self.id}")
      Bj.submit("./script/runner ./lib/jobs/build_items.rb #{self.id}")
    end
    
    def generate_hash
      require RAILS_ROOT + '/lib/pathname_ext.rb'
      update_attribute(:local_file_hash, Pathname.new(self.local.path).digest.to_s)
    end
end