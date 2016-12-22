class CreateFlashSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :flash_sessions do |t|
      t.datetime :date
      t.integer :user_id
      t.integer :agent_id
      t.string :description
      t.integer :length

      t.timestamps
    end
  end
end
