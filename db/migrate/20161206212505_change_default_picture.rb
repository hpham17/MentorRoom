class ChangeDefaultPicture < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :picture, 'blank.png'
  end
end
