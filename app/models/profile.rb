class Profile < ApplicationRecord
  belongs_to :user
  serialize :degrees
  validates :role, :location, :linkedin, :bio, :school, :major, :degrees, :gradyear, presence: true
end
