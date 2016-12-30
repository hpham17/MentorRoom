class Profile < ApplicationRecord
  belongs_to :user
  serialize :degrees
end
