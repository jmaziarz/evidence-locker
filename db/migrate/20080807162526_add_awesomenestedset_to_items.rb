class AddAwesomenestedsetToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :parent_id, :integer
    add_column :items, :root_id, :integer
    add_column :items, :lft, :integer
    add_column :items, :rgt, :integer
  end

  def self.down
    remove_column :items, :rgt
    remove_column :items, :lft
    remove_column :items, :root_id
    remove_column :items, :parent_id
  end
end
