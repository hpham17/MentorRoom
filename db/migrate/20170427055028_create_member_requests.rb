class CreateMemberRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :member_requests do |t|
      t.integer :organization_id
      t.integer :user_id

      t.timestamps
    end
  end
end
