class CreateWatchings < ActiveRecord::Migration
  def self.up
    create_table :watchings, :id => false do |t|
      t.integer :member_id, :required => true
      t.integer :book_id, :required => true
      t.timestamps
    end
  end

  def self.down
    drop_table :watchings
  end
end
