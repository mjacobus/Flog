class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :file_file_name
      t.string :file_content_type
      t.datetime :file_updated_at
      t.integer :file_file_size

      t.timestamps
    end
  end
end
