# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  content         :string
#  user_id         :integer
#  chatroom_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notification_id :integer
#

class Message < ApplicationRecord
  attr_accessor :current_user
  attr_accessor :other_user
  belongs_to :chatroom, touch: true
  belongs_to :user
  belongs_to :notification
  after_create_commit { MessageBroadcastJob.perform_now(self, self.current_user, self.other_user) }

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end
