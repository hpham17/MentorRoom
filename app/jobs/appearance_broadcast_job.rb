class AppearanceBroadcastJob < ApplicationJob
  queue_as :default

  def perform(list)
    ActionCable.server.broadcast 'appearance', appearances: list
  end
end
