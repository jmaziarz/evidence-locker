class AddRemotePathToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :remote_path, :string
    add_column :items, :remote_username, :string
    add_column :items, :remote_password, :string
    add_column :items, :remote_authenticate, :boolean, :default => false
    add_column :items, :remote_file_size, :integer
    add_column :items, :remote_content_type, :string
    add_column :items, :remote_file_hash, :string
  end

  def self.down
    remove_column :items, :remote_path
    remove_column :items, :remote_username
    remove_column :items, :remote_password
    remove_column :items, :remote_authenticate
    remove_column :items, :remote_file_size
    remove_column :items, :remote_content_type
    remove_column :items, :remote_file_hash
  end
end
