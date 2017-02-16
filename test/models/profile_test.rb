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

require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
