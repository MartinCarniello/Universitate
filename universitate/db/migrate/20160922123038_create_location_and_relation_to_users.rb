class CreateLocationAndRelationToUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :full_address
      t.integer :lat
      t.integer :lng
      t.integer :user_id

      t.timestamps
    end
  end
end
