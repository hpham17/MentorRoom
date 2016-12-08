class Notification < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :nullify

  def messages?
    self.count > 0 ? count : false
  end
end