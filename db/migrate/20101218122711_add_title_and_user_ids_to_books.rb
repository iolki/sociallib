class AddTitleAndUserIdsToBooks < ActiveRecord::Migration
  def self.up
    drop_table :books
    
    create_table :books do |t|
      t.references :title, :user
      t.timestamps
    end
  end

  def self.down
  end
end
