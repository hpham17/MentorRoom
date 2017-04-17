class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, chatroom_id, user, other_id)
      ActionCable.server.broadcast "chatrooms_#{chatroom_id}_channel",
                                message: render_message(message, user)
      # ActionCable.server.broadcast "chatrooms_#{user}_channel",
      #                             message: render_message(message, user)
      # ActionCable.server.broadcast "chatrooms_#{other_id}_channel",
      #                             message: render_message(message, other_id)
  end

  private

  def render_message(message, user)
    user = User.find(user)
    MessagesController.render_with_signed_in_user(user, partial: 'messages/message', locals: {message: message})
  end
end
