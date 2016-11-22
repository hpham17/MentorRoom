class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :role
      t.string :location
      t.string :linkedin
      t.string :bio
      t.string :school

      t.timestamps
    end
  end
end
