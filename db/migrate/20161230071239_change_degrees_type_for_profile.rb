class ChangeDegreesTypeForProfile < ActiveRecord::Migration[5.0]
  def change
    change_column :profiles, :degrees, :text
  end
end
