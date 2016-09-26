class AddUserColumnToRating < ActiveRecord::Migration[5.0]
  def self.up
    add_column :ratings, :user_id,:integer
  end

  def self.down
    remove_column :ratings, :user_id
  end
end
