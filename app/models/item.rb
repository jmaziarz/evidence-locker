class Item < ActiveRecord::Base
  ## Associations  
  has_many :references, :dependent => :destroy
  has_many :transformations, :dependent => :destroy
  has_many :categorizations
  has_many :categories, :through => :categorizations

  ## Callbacks
  after_create :assign_root_attributes
  
  ## Plugins
  acts_as_nested_set :scope => :root
  stampable
  
  ## ThinkingSphinx full-text search plugin
  define_index do
    indexes title
    indexes description
    indexes identifier
  end
  
  ## Validations
  validates_presence_of :title
  validates_presence_of :origin
  validates_presence_of :originated_at
  validates_uniqueness_of :title
  
  ## Class methods
  
  def self.factory(klass = 'self.class_name', params = {})
    klass.capitalize.constantize.new(params)
  end
  
  def self.maximum_sequence
    Item.maximum(:sequence) || 0
  end
  
  ## Instance methods
      
  def sequence(padded = false)
    padded ? padded_sequence : self[:sequence]
  end 
  
  def identifier
    self[:identifier] ? self[:identifier] : generate_identifier
  end
  
  def file_size
    self[:local_file_size] ||= self[:remote_file_size] 
  end
  
  def file_hash
    self[:local_file_hash] ||= self[:remote_file_hash]
  end
  
  def content_type
    self[:local_content_type] ||= self[:remote_content_type]
  end
    
  private
  
    def padded_sequence(length = 6, str = '0')
      self[:sequence].to_s.rjust(length, str)
    end
    
    def generate_sequence
      self.class.maximum_sequence + 1
    end
    
    def generate_identifier
      "#{self.created_at.strftime('%y%m%d')}-#{padded_sequence}"
    end
  
    ## Callback methods
     
    def assign_root_attributes
      if self.root_id.nil?
        update_attribute(:sequence, generate_sequence)
        update_attribute(:identifier, generate_identifier)
        update_attribute(:root_id, self.id)
      end
    end
end