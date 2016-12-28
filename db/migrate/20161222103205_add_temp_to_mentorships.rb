class AddTempToMentorships < ActiveRecord::Migration[5.0]
  def change
    add_column :mentorships, :temp, :boolean, default: false
  end
end
