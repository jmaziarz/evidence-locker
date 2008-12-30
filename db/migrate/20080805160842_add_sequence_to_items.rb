class AddSequenceToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :sequence, :integer
  end

  def self.down
    remove_column :items, :sequence
  end
end
