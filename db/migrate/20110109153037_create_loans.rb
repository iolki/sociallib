class CreateLoans < ActiveRecord::Migration
  def self.up
    create_table :loans do |t|
      t.integer :book_id, :required => true
      t.integer :lender_id, :required => true
      t.integer :borrower_id, :required => true
      t.date    :due, :required => true
      t.datetime :returned
      t.timestamps
    end
    
    add_column :books, :status, :integer, :default => 0
  end

  def self.down
    drop_table :loans
    remove_column :books, :status
  end
end
