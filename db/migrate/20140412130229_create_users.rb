class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :mail
      t.string :password
      t.date :birth
      t.string :gender
      t.string :img_id

      t.timestamps
    end
  end
end
