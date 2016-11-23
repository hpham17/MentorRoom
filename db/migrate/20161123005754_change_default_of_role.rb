class ChangeDefaultOfRole < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :role, :string, :default => nil
  end
end
