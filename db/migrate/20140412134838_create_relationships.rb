class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.belongs_to :user
      t.string :status

      t.timestamps
    end
  end
end
