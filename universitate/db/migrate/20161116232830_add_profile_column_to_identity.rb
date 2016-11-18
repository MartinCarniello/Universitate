class AddProfileColumnToIdentity < ActiveRecord::Migration[5.0]
  def self.up
    add_column :identities, :profile_url,:string
  end

  def self.down
    remove_column :identities, :profile_url
  end
end
