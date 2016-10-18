class AddDirectMessageIdToChatrooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chatrooms, :direct_message_id, :integer
  end
end
