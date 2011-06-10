class AddIdToWatchings < ActiveRecord::Migration
  def self.up
    drop_table :watchings

    create_table :watchings do |t|
      t.integer :user_id, :required => true
      t.integer :book_id, :required => true
      t.timestamps
    end
  end

  def self.down
  end
end
