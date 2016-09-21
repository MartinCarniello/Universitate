class CreateComments < ActiveRecord::Migration[5.0]
  def self.up
    create_table :comments do |t|
      t.string :comment
      t.integer :comment_replied_id
    end
  end

  def self.down
    drop_table :comments
  end
end
