class CreateAnnouncements < ActiveRecord::Migration[5.0]
  def change
    create_table :announcements do |t|
      t.string :title
      t.string :body
      t.integer :organization_id

      t.timestamps
    end
  end
end
