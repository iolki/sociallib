class AddResultsCountToSearches < ActiveRecord::Migration
  def self.up
    add_column :searches, :results, :integer
  end

  def self.down
    remove_column :searches, :results
  end
end
