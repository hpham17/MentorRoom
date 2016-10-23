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
  validates :topic, presence: true, uniqueness: true
  before_validation :sanitize, :slugify

  def other_user(id)
    self.users.each do |u|
      if u.id != id
        return User.find(u.id).name
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
