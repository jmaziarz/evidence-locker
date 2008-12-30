class MigrateTo2Dot0 < ActiveRecord::Migration
  def self.up
    # indexes
    remove_index "categories_items", "item_id"
    remove_index "categories_items", "category_id"
    remove_index "sessions", "updated_at"
    remove_index "sessions", "session_id"
    
    # categories
    rename_column "categories", "created_on", "created_at"
    add_column "categories", "updated_at", :datetime
    
    # categories_items
    rename_table "categories_items", "categorizations"
    add_column "categorizations", "created_at", :datetime
    add_column "categorizations", "updated_at", :datetime
    
    # ereferences
    rename_column "ereferences", "created_by", "created_id"
    rename_column "ereferences", "updated_by", "updated_id"
    rename_column "ereferences", "created_on", "created_at"
    rename_column "ereferences", "updated_on", "created_at"

    # sessions
    drop_table "sessions"
    
    # users
    add_column "users", "name", :string
    
    User.reset_column_information
    User.find(:all).each do |user|
      first_name = user.first_name ||= ''
      last_name = user.last_name ||= ''
      user.name = first_name + ' ' + last_name
      user.save(false)
    end
    
    remove_column "users", "first_name"
    remove_column "users", "last_name"
    
    # transformations
    rename_column "transformations", "created_on", "created_at"
    rename_column "transformations", "updated_on", "updated_at"
    add_column "transformations", "creator_id", :integer
    add_column "transformations", "updator_id", :integer
    add_column "transformations", "data_file_name", :string
    add_column "transformations", "data_file_size", :integer
    add_column "transformations", "data_content_type", :string
      
    Transformation.reset_column_information
    Transformation.find(:all).each do |transformation|
      transformation.transformation_files.each do |transformation_file|
        new_transformation = Transformation.new
        new_transformation.data_file_name = transformation_file.filename
        new_transformation.data_file_size = transformation_file.size
        new_transformation.data_content_type = transformation_file.content_type
        new_transformation.creator_id = transformation_file.created_by.id
        new_transformation.updator_id = transformation_file.updated_by.id
        new_transformation.created_at = transformation_file.created_on
        new_transformation.item_id = transformation.item_id
        new_transformation.save
      end
      transformation.destroy_without_callbacks
    end
    
    # transformation_files
    drop_table "transformation_files"
    
    # items
    rename_column "items", "originated_on", "originated_at"
    rename_column "items", "created_on", "created_at"
    rename_column "items", "updated_on", "updated_at"
    rename_column "items", "created_by", "creator_id"
    rename_column "items", "updated_by", "updator_id"
    rename_column "items", "size", "remote_file_size"
    rename_column "items", "type", "remote_content_type"
    rename_column "items", "file_hash", "remote_file_hash"
    add_column "items", "local_file_name", :string
    add_column "items", "local_content_type", :string
    add_column "items", "local_file_size", :integer
    add_column "items", "local_unpack", :boolean, :default => false
    add_column "items", "local_file_hash", :string
    add_column "items", "remote_path", :string
    add_column "items", "relative_path", :string
    add_column "items", "remote_username", :string
    add_column "items", "remote_password", :string
    add_column "items", "remote_authenticate", :boolean, :default => false
    add_column "items", "item_type", :string
    change_column "items", "remote_file_size", :integer
    
    Item.reset_column_information
    Item.find(:all).each do |item|
      unless item.evidence_file.nil?
        # Local items
        item.local_file_name = item.evidence_file.filename
        item.local_file_size = item.evidence_file.size.to_i
        item.local_content_type = item.evidence_file.content_type
        item.local_file_hash = item.evidence_file.file_hash
        item.item_type = "Local"
      else
        # Remote items
        if item.root_id == item.id
          item.remote_path = item.path
          item.relative_path = nil
        else
          item.remote_path = nil
          item.relative_path = item.path[Item.find(item.root_id).path.size, item.path.size] + "/#{item.name}"
        end
        item.item_type = "Remote"
      end
      item.save(false)
    end
    
    remove_column "items", "path"
    remove_column "items", "name"
    rename_column "items", "item_type", "type"
    
    # evidence_files
    drop_table "evidence_files"
    
    # artifically apply all other migrations
    execute "INSERT INTO schema_migrations (version) VALUES ('20080711232153')" # 20080711232153_create_items.rb
    execute "INSERT INTO schema_migrations (version) VALUES ('20080731150723')" # 20080731150723_add_local_file_to_items.rb
    execute "INSERT INTO schema_migrations (version) VALUES ('20080805160842')" # 20080805160842_add_sequence_to_items.rb
    execute "INSERT INTO schema_migrations (version) VALUES ('20080805164415')" # 20080805164415_add_identifier_to_items.rb
    execute "INSERT INTO schema_migrations (version) VALUES ('20080807162526')" # 20080807162526_add_awesomenestedset_to_items.rb
    execute "INSERT INTO schema_migrations (version) VALUES ('20080828183859')" # 20080828183859_add_relative_path_to_items.rb
    execute "INSERT INTO schema_migrations (version) VALUES ('20080905165612')" # 20080905165612_add_remote_path_to_items.rb
    execute "INSERT INTO schema_migrations (version) VALUES ('20080924212506')" # 20080924212506_create_references.rb
    execute "INSERT INTO schema_migrations (version) VALUES ('20080925194222')" # 20080925194222_create_transformations.rb
    execute "INSERT INTO schema_migrations (version) VALUES ('20080926161843')" # 20080926161843_create_categories.rb
    execute "INSERT INTO schema_migrations (version) VALUES ('20080926174939')" # 20080926174939_create_categorizations.rb
    execute "INSERT INTO schema_migrations (version) VALUES ('20081001222330')" # 20081001222330_create_users.rb    
  end
  
  def self.down
    # not much we can do to restore deleted data
    raise ActiveRecord::IrreversibleMigration, "Can't migrate backwards"
  end
end

# Redefine models to override callbacks and other goodness
class Transformation < ActiveRecord::Base
  belongs_to :item
  has_many :transformation_files
end

class TransformationFile < ActiveRecord::Base
  belongs_to :transformation
end

class Item < ActiveRecord::Base
  has_one :evidence_file
end

class EvidenceFile < ActiveRecord::Base
  belongs_to :item
end
