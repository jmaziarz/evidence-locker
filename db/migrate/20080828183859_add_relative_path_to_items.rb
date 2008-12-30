class AddRelativePathToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :relative_path, :string
  end

  def self.down
    remove_column :items, :relative_path
  end
end
