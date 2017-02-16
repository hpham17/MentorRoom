# == Schema Information
#
# Table name: flash_sessions
#
#  id          :integer          not null, primary key
#  date        :datetime
#  user_id     :integer
#  agent_id    :integer
#  description :string
#  length      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  accepted    :boolean
#

class FlashSession < ApplicationRecord
  belongs_to :user
end
