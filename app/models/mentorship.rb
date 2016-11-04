# == Schema Information
#
# Table name: mentorships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  mentor_id  :integer
#  accepted   :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Mentorship < ApplicationRecord
  belongs_to :user
  belongs_to :mentor, :class_name => 'User'
  validates :mentor_id, presence: true
  validates :user_id, presence: true
end
