# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  content     :string
#  user_id     :integer
#  chatroom_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :chatroom, touch: true
  belongs_to :user
  belongs_to :notification
end
