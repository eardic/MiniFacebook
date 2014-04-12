class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :user
      t.integer :to_user_id
      t.text :message

      t.timestamps
    end
  end
end
