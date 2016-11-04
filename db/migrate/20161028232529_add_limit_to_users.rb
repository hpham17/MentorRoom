class AddLimitToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :limit, :integer
  end
end
