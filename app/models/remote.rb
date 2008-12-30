class Remote < Item
  ## Callbacks
  after_create :traverse_in_background, :if => :unc?
  after_create :mirror_in_background, :if => :url?

  ## Validations
  validates_presence_of :remote_path
  validates_uniqueness_of :remote_path, :message => "is already in use"
  
  ## Instance methods
  
  def unc?
    Regexp.new('^[\\/]{2}.*').match(self.remote_path)
  end
  
  def url?
    Regexp.new('^http|https.*').match(self.remote_path)
  end
  
  private
  
    ## Callback methods
  
    def traverse_in_background
      Bj.submit("./script/runner ./lib/jobs/remote_traverse.rb #{self.id}") if self.root_id == self.id
    end
    
    def mirror_in_background
      Bj.submit("./script/runner ./lib/jobs/remote_mirror.rb #{self.id}")
    end
end