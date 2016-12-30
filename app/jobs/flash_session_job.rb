class FlashSessionJob < ApplicationJob
  queue_as :default

  def perform(mentor_id, mentee_id)
    Mentorship.create! mentor_id: mentor_id, user_id: mentee_id, accepted: true, temp: true
    chatroom = Chatroom.where(topic: mentor_id.to_s + "_to_" + mentee_id.to_s).first_or_create!
    Message.create! user_id: mentor_id, content: " has joined the room.", chatroom_id: chatroom.id
    Message.create! user_id: mentee_id, content: " has joined the room.", chatroom_id: chatroom.id
    Message.create! user_id: mentor_id, content: "I have accepted your request and will be back at the appointed time to help you.", chatroom_id: chatroom.id
  end
end
