# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  role                   :string           default("Mentee")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  remember_created_at    :datetime
#  block                  :boolean
#  limit                  :integer
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ROLES = %w[Admin Mentor Mentee].freeze
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages
  has_many :chatrooms, through: :messages
  has_many :mentorships, -> { where accepted: true }
  has_many :mentors, through: :mentorships
  has_many :inverse_mentorships, -> { where accepted: true }, :class_name => "Mentorship", :foreign_key => "mentor_id"
  has_many :mentees, :through => :inverse_mentorships, :source => :user

  def is?(role)
    self.role == role.to_s
  end

  def check_limit
    if self.mentees.count == limit
      return "block"
    end
  end

  def requested_mentor?(id)
    a = Mentorship.where(mentor_id: id, user_id: self.id, accepted: false)
  end
end
