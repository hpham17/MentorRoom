class CreateStars < ActiveRecord::Migration[5.0]
  def change
    create_table :stars do |t|
      t.integer :user_id, index: true
      t.integer :starred_id, index: true

      t.timestamps
    end
  end
end
