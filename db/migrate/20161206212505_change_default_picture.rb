class ChangeDefaultPicture < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :picture, :string, :default => "blank.png"
  end
end
