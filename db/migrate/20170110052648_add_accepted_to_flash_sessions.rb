class AddAcceptedToFlashSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :flash_sessions, :accepted, :boolean
  end
end
