class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :user
      t.integer :friend_id
      t.integer :notif_type # 0:post, 1:like, 2:dislike, 3:comment
      t.text :content
      t.integer :element_id # id of post, or maybe comment

      t.timestamps
    end
  end
end
