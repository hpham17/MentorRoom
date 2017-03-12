# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  role       :string
#  location   :string
#  linkedin   :string
#  bio        :string
#  school     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company    :string
#  major      :string
#  degrees    :text
#  clubs      :string
#  gradyear   :integer
#  sports     :string
#  languages  :string
#  ethnicity  :string
#  hobbies    :string
#  website    :string
#  twitter    :string
#  sector     :string
#

class Profile < ApplicationRecord
  belongs_to :user
  serialize :degrees
  serialize :ethnicity
  serialize :identity
  validates :role, :major, :ethnicity, :location, :bio, :school, :aspirations, :major, :gradyear, :company, presence: true
end
