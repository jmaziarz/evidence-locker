class Category < ActiveRecord::Base
  ## Associations
  has_many :categorizations
  has_many :items, :through => :categorizations

  ## Callbacks
  after_save :move_to_child
    
  ## Plugins
  acts_as_nested_set :scope => :root
  
  attr_accessor :child_of
  
  private
  
    ## Callback methods

    def move_to_child
      self.move_to_child_of(Category.find(self.child_of)) unless self.child_of.empty?
    end
end
