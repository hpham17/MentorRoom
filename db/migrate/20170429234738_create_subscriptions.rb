class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.string :subscription_id
      t.string :subscription_path
      t.string :endpoint
      t.string :key_p256dh
      t.string :key_auth
    end
  end
end
