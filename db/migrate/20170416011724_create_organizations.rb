class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.integer :size
      t.string :invite_link
      t.boolean :trial
      t.string :about
      t.string :renewal_date
      t.integer :creator_id
      t.string :logo
      t.boolean :private

      t.timestamps
    end
  end
end
