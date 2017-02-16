# == Schema Information
#
# Table name: stars
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  starred_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Star < ApplicationRecord
  belongs_to :user
  belongs_to :starred, :class_name => "User"
  validates :user_id, uniqueness: { scope: :starred_id }
end
