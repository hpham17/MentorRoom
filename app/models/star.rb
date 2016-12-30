class Star < ApplicationRecord
  belongs_to :user
  belongs_to :starred, :class_name => "User"
  validates :user_id, uniqueness: { scope: :starred_id }
end
