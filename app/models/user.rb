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
#  role                   :string
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
#  limit                  :integer
#  picture                :string           default("blank.png")
#  online                 :boolean
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  ROLES = %w[Admin Mentor Mentee].freeze
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :linkedin]
  has_one :profile
  has_many :messages
  has_one :notification
  has_many :flash_sessions
  has_many :stars
  has_many :activities
  has_many :starred, through: :stars
  has_many :chatrooms, through: :messages
  has_many :mentorships, -> { where accepted: true }
  has_many :mentors, through: :mentorships
  has_many :inverse_mentorships, -> { where accepted: true }, :class_name => "Mentorship", :foreign_key => "mentor_id"
  has_many :mentees, :through => :inverse_mentorships, :source => :user
  acts_as_taggable_on :skills, :help
  has_friendship
  accepts_nested_attributes_for :profile
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  after_save { Notification.create! user_id: self.id unless self.notification}

  def is?(role)
    self.role == role.to_s
  end

  def isFriend?(user)
    self.friends_with? user
  end

  def requests
    self.requested_friends
  end

  def requested?(user)
    self.pending_friends.include? user
  end

  def check_limit
    if self.mentees.count == limit
      return "block"
    end
  end

  def add_skill(skill)
    self.skill_list.add(skill)
    self.save
  end

  def add_help(help)
    self.help_list.add(help)
    self.save
  end
  def star!(starred)
    self.stars.create!(starred_id: starred.id)
  end

  # destroys a heart with matching post_id and user_id
  def unstar!(starred)
    star = self.stars.find_by_starred_id(starred.id)
    star.destroy!
  end

  # returns true of false if a user is starred by user
  def star?(starred)
    self.stars.find_by_starred_id(starred.id)
  end

  def requested_mentor?(id)
    a = Mentorship.where(mentor_id: id, user_id: self.id, accepted: false)
  end
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update


  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.info.name,
          picture: auth.info.image,
          #username: auth.info.nickname || auth.uid,
          email: auth.info.email ? auth.info.email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        #user.skip_confirmation!
        user.save!
      end
    end

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.picture = auth.info.image # assuming the user model has an image
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
end
