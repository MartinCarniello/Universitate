class AddMessagesCountToConversations < ActiveRecord::Migration[5.0]
  def self.up
    add_column :conversations, :first_user_messages_count, :integer, default: 0
    add_column :conversations, :second_user_messages_count, :integer, default: 0
  end

  def self.down
    remove_column :conversations, :first_user_messages_count
    remove_column :conversations, :second_user_messages_count
  end
end
