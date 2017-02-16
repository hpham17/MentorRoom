# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  seen       :boolean          default(FALSE)
#  count      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ApplicationRecord
  belongs_to :user
  validates :user_id, uniqueness: true
  has_many :messages, dependent: :nullify

  def messages?
    self.count > 0 ? count : false
  end
end
