class RemoveDueFromLoans < ActiveRecord::Migration
  def self.up
    remove_column :loans, :due
  end

  def self.down
    add_column :loans, :due, :date
  end
end
