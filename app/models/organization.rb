class Organization < ApplicationRecord
  has_many :users, dependent: :nullify
  has_one :chatroom
  has_many :invites
  has_many :messages, through: :chatrooms
  has_many :announcements, dependent: :destroy
  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  after_commit :create_chatroom, on: :create
  validates :name, presence: true, uniqueness: true

  private
    def create_chatroom
      Chatroom.create!(topic: self.name, organization_id: self.id)
    end
end
