class AddEthnicityToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :aspirations, :string
    add_column :profiles, :identity, :string
  end
end
