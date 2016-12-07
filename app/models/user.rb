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
  has_many :chatrooms, through: :messages
  has_many :mentorships, -> { where accepted: true }
  has_many :mentors, through: :mentorships
  has_many :inverse_mentorships, -> { where accepted: true }, :class_name => "Mentorship", :foreign_key => "mentor_id"
  has_many :mentees, :through => :inverse_mentorships, :source => :user
  acts_as_taggable_on :skills, :help
  accepts_nested_attributes_for :profile
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  after_save { Notification.create! user_id: self.id }

  def is?(role)
    self.role == role.to_s
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
        if auth.provider == "linkedin"
          user.build_profile(linkedin: auth.info.urls.public_profile, location: auth.info.location, role: auth.info.description)
        end
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
