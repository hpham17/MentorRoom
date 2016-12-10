class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "appearance"
    current_user.online = true
    current_user.save
    ActionCable.server.broadcast 'appearance',
        user: current_user.name,
        action: 'online'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    current_user.online = false
    current_user.save
    ActionCable.server.broadcast 'appearance',
        user: current_user.name,
        action: 'offline'
  end
end
