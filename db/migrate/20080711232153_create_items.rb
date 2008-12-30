class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :title
      t.text :description
      t.text :origin
      t.date :originated_at
      t.string :type
      
      t.userstamps
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
