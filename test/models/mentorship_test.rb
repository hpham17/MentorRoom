# == Schema Information
#
# Table name: mentorships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  mentor_id  :integer
#  accepted   :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class MentorshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
