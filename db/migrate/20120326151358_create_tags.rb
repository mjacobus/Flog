class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :slug
      t.integer :count
      t.integer :posts_count,:default => 0

      t.timestamps
    end
    
    add_index :tags, :name, :unique => true    
    add_index :tags, :slug, :unique => true
  end
end
