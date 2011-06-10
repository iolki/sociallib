class CreateTitles < ActiveRecord::Migration
  def self.up
    create_table :titles do |t|
      t.string    :isbn13, :limit => 13, :required => true, :default => ''
      t.string    :title, :required => true, :default => ''
      t.string    :subtitle
      t.text      :description
      t.string    :image_url, :limit => 255
      t.integer   :subject_id
      t.timestamps
    end
  end

  def self.down
    drop_table :titles
  end
end
