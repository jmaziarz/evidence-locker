class Transformation < ActiveRecord::Base
  ## Associations
  belongs_to :item
  
  ## Plugins
  # Paperclip interpolations are defined in config/initializers/paperclip.rb
  has_attached_file :data, :url => "/#{File.basename(DATA_PATH)}/:item_identifier/transformations/:item_identifier-:item_id-:id.:extension", :path => "#{DATA_PATH}/:item_identifier/transformations/:item_identifier-:item_id-:id.:extension"
  stampable
  
  ## Instance methods
  
  def interpolated_file_name
    File.basename(self.data.path)
  end
end
