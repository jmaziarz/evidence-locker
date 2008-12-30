class Reference < ActiveRecord::Base
  ## Associations
  belongs_to :item
  
  ## Plugins
  stampable
  
  set_table_name 'ereferences'
end
