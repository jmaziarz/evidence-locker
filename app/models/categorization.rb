class Categorization < ActiveRecord::Base
  ## Associations
  belongs_to :category
  belongs_to :item
end
