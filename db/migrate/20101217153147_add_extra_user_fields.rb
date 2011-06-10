class AddExtraUserFields < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string    :login,               :null => false, :default => ''
      t.string    :email,               :null => false, :default => ''
      t.string    :crypted_password,    :null => false, :default => ''
      t.string    :password_salt,       :null => false, :default => ''
      t.string    :persistence_token,   :null => false, :default => ''
      t.string    :single_access_token, :null => false, :default => ''
      t.string    :perishable_token,    :null => false, :default => ''
      t.integer   :login_count,         :null => false, :default => 0
      t.integer   :failed_login_count,  :null => false, :default => 0
      t.datetime  :last_request_at
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip
    end
   end

  def self.down
    change_table :users do |t|
      t.remove_column :login
      t.remove_column :email
      t.remove_column :crypted_password
      t.remove_column :password_salt
      t.remove_column :persistence_token
      t.remove_column :single_access_token
      t.remove_column :perishable_token
      t.remove_column :login_count
      t.remove_column :failed_login_count
      t.remove_column :last_request_at
      t.remove_column :current_login_at
      t.remove_column :last_login_at
      t.remove_column :current_login_ip
      t.remove_column :last_login_ip
    end
  end
end
