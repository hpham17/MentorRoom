class Organization < ApplicationRecord
  has_many :organization_users
  has_many :users, through: :organization_users
  has_one :chatroom, dependent: :destroy
  has_many :invites, dependent: :destroy
  has_many :messages, through: :chatrooms
  has_many :member_requests
  has_many :announcements, dependent: :destroy
  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  after_commit :create_chatroom, on: :create
  validates :name, presence: true, uniqueness: true

  def user_belongs_to_org?(id)
     user = User.find id
     self.users.include? user
  end

  def not_requested?(id)
    self.member_requests.where(:user_id => id).empty?
  end

  def accept_user(id)
    OrganizationUser.create! organization_id: self.id, user_id: id
    MemberRequest.where(organization_id: self.id, user_id: id).first.destroy
  end

  private


    def create_chatroom
      Chatroom.create!(topic: self.name, organization_id: self.id)
    end
end
