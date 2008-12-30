class CreateReferences < ActiveRecord::Migration
  def self.up
    create_table :ereferences do |t|
      t.string :name
      t.text :description
      t.string :bookmark
      t.integer :item_id

      t.userstamps
      t.timestamps
    end
  end

  def self.down
    drop_table :ereferences
  end
end
