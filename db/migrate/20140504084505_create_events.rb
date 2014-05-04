class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.string :name
      t.text :details
      t.string :where
      t.date :when
      t.time :begin_time
      t.date :until
      t.time :end_time

      t.timestamps
    end
  end
end
