class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :from_user_id
      t.belongs_to :user

      t.timestamps
    end
  end
end
