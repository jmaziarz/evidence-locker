class CreateTransformations < ActiveRecord::Migration
  def self.up
    create_table :transformations do |t|
      t.string :data_file_name
      t.string :data_content_type
      t.integer :data_file_size
      t.integer :item_id

      t.userstamps
      t.timestamps
    end
  end

  def self.down
    drop_table :transformations
  end
end
