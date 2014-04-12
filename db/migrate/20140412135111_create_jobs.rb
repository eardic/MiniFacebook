class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.belongs_to :user
      t.string :company
      t.string :title
      t.date :begin_date
      t.date :end_date

      t.timestamps
    end
  end
end
