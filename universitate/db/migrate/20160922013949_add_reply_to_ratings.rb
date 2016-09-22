class AddReplyToRatings < ActiveRecord::Migration[5.0]
  def self.up
    add_column :ratings, :reply, :string
  end

  def self.down
    remove_column :ratings, :reply
  end

end
