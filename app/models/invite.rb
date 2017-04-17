class Invite < ApplicationRecord
  before_create :generate_token
  before_save :check_user_existence
  belongs_to :organization
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'

  def check_user_existence
    recipient = User.find_by_email(email)
    if recipient
      self.recipient_id = recipient.id
    end
  end

  def generate_token
     self.token = Digest::SHA1.hexdigest([self.organization_id, Time.now, rand].join)
  end
end
