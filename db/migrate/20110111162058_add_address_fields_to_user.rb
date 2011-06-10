class AddAddressFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name,  :string
    add_column :users, :address1,   :string
    add_column :users, :address2,   :string
    add_column :users, :city,       :string
    add_column :users, :county,     :string
    add_column :users, :postcode,   :string
    add_column :users, :phone,      :string
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :address1
    remove_column :users, :address2
    remove_column :users, :city
    remove_column :users, :county
    remove_column :users, :postcode
    remove_column :users, :phone
  end
end
