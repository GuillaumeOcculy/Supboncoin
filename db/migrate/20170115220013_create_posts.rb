class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.text :description
      t.float :price
      t.belongs_to :category, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
    add_index :posts, :name
  end
end
