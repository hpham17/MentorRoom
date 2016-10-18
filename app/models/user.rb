class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages
  has_many :chatrooms, through: :messages
  has_many :senders, :class_name => 'DirectMessage', :foreign_key => 'sender_id'
  has_many :chatrooms, through: :senders
  has_many :receivers, :class_name => 'DirectMessage', :foreign_key => 'receiver_id'
  has_many :chatrooms, through: :receivers
end
