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
