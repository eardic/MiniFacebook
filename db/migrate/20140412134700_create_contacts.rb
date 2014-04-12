class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.belongs_to :user
      t.string :tel
      t.string :city
      t.string :country
      t.text :address

      t.timestamps
    end
  end
end
