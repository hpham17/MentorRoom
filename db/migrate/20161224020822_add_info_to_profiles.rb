class AddInfoToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :company, :string
    add_column :profiles, :major, :string
    add_column :profiles, :degrees, :string
    add_column :profiles, :clubs, :string
    add_column :profiles, :gradyear, :integer
    add_column :profiles, :sports, :string
    add_column :profiles, :languages, :string
    add_column :profiles, :ethnicity, :string
    add_column :profiles, :hobbies, :string
    add_column :profiles, :website, :string
    add_column :profiles, :twitter, :string
    add_column :profiles, :sector, :string
  end
end
