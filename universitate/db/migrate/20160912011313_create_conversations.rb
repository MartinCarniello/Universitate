class CreateConversations < ActiveRecord::Migration[5.0]
  def self.up
    create_table :conversations do |t|
      t.integer :first_user_id
      t.integer :second_user_id

      t.timestamps
    end

    add_column :messages, :conversation_id, :integer
  end

  def self.down
    drop_table :conversations
    remove_column :messages, :conversation_id
  end
end
