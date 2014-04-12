class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.belongs_to :user
      t.string :high_school
      t.string :college

      t.timestamps
    end
  end
end
