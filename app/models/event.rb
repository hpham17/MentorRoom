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
