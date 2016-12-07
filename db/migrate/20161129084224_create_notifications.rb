class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.boolean :seen, default: false
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
