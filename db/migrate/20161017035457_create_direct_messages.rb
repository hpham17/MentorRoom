class CreateDirectMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :direct_messages do |t|
      t.integer :sender_id
      t.integer :receiver_id

      t.timestamps
    end
  end
end
