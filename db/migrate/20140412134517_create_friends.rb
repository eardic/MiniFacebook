class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.belongs_to :user
      t.integer :friend_id

      t.timestamps
    end
  end
end
