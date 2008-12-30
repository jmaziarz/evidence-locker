class AddLocalFileToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :local_file_name, :string
    add_column :items, :local_content_type, :string
    add_column :items, :local_file_size, :integer
    add_column :items, :local_unpack, :boolean, :default => false
    add_column :items, :local_file_hash, :string
  end

  def self.down
    remove_column :items, :local_file_name
    remove_column :items, :local_content_type
    remove_column :items, :local_files_size
    remove_column :items, :local_unpack
    remote_column :items, :local_file_hash
  end
end
