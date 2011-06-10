class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.string  :name, :required => true, :limit => 255, :default => ''
      t.timestamps
    end
    
    create_table :authors_titles, :id => false do |t|
      t.references :author, :title
    end
    
    add_index :authors_titles, :author_id
    add_index :authors_titles, :title_id
  end

  def self.down
    drop_table :authors_titles
    drop_table :authors
  end
end
