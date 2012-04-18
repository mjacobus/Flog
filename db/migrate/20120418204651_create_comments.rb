class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :post
      t.string :email
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
