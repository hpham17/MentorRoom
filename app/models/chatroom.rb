# == Schema Information
#
# Table name: chatrooms
#
#  id         :integer          not null, primary key
#  topic      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, -> { distinct }, through: :messages
  belongs_to :organization
  validates :topic, presence: true, uniqueness: true
  before_validation :sanitize, :slugify
  # after_touch do |chatroom|
  #   if messages.count >= 2
  #     create_notification chatroom
  #   end
  # end

  def create_notification(chatroom)
    last_message = chatroom.messages.last
    user = last_message.user
    other_user = chatroom.other_user user.id
    n = other_user.notification || Notification.create(user_id: other_user.id)
    n.count += 1
    n.save
    last_message.notification_id = n.id
    last_message.save
    NotificationsChannel.broadcast_to other_user,
        user: last_message.user.name,
        content: last_message.content,
        picture: last_message.user.picture,
        topic: self.topic,
        id: last_message.id
  end

  def other_user(id, name = false)
    self.users.each do |u|
      if u.id != id
        if name
          return User.find(u.id).name
        else
          return User.find(u.id)
        end
      end
    end
  end

  def count_new_messages(current_user)
    count = 0
    @all_messages = self.messages.order(:created_at).dup.to_a
    @user = @all_messages.last.user_id
    if @user != current_user
      while @all_messages.last.user_id == @user
        count += 1
        @all_messages.pop
      end
    end
    count
  end

  def to_param
    self.slug
  end

  def slugify
    self.slug = self.topic.downcase.gsub(" ", "-")
  end

  def sanitize
    self.topic = self.topic.strip
  end
end
