class FlashSessionWorker
  include Sidekiq::Worker

  def perform(mentor_id, mentee_id)
    Mentorship.create! mentor_id: mentor_id, user_id: mentee_id, accepted: true
    @chatroom = Chatroom.create! topic: mentor_id.to_s + "_to_" + mentee_id.to_s
    @message1 = Message.new user_id: mentor_id, content: " has joined the room.", chatroom_id: @chatroom.id
    @message2 = Message.new user_id: mentee_id, content: " has joined the room.", chatroom_id: @chatroom.id
    @chatroom.messages << @message1
    @chatroom.messages << @message2
    @chatroom.save
  end
end
