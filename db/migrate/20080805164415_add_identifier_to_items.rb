class AddIdentifierToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :identifier, :string
  end

  def self.down
    remove_column :items, :identifier
  end
end
