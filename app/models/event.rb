# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  start      :datetime
#  end        :datetime
#  title      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ApplicationRecord
  validates :start, :end, presence: true
  validates :start, :end, date: true
  validates :start,
  date: { after: Proc.new { Date.today }, message: 'must be after today' },
  on: :create
  validates :start, date: { before: :end }
  def format
    self.strftime("%Y%m%dT%H%M")
  end
end
