class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.text :post
      t.integer :like
      t.integer :dislike

      t.timestamps
    end
  end
end
