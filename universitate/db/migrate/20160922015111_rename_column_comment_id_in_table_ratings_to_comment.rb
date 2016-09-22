class RenameColumnCommentIdInTableRatingsToComment < ActiveRecord::Migration[5.0]
  def self.up
    change_table :ratings do |t|
      t.rename :comment_id, :comment
      t.change :comment, :string
    end
  end

  def self.down
    change_table :ratings do |t|
      t.rename :comment, :comment_id
      t.change :comment, :integer
    end
  end
end
