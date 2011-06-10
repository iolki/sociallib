class AddUsersToWatchings < ActiveRecord::Migration
  def self.up
    rename_column :watchings, :member_id, :user_id
  end

  def self.down
    rename_column :watchings, :user_id, :member_id
  end
end
