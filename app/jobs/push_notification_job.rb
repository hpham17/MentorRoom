class PushNotificationJob < ApplicationJob
  include Rails.application.routes.url_helpers

  queue_as :default

  def perform(message, chatroom_id, user, other_id)
    user = User.find(user)
    org = Chatroom.find(chatroom_id).organization
    message = {
        title: "#{org.name}",
        body: "#{user.name}: #{message.content}. CLick to view it.",
        icon: 'https://avatars2.githubusercontent.com/u/7391673?v=3&s=200',
        open_url: organization_path(org.id)
    }

    subscriptions = Subscription.all

    subscriptions.each do |subscription|
      Webpush.payload_send(
        endpoint: subscription.endpoint,
        message: JSON.generate(message),
        p256dh: subscription.key_p256dh,
        auth: subscription.key_auth,
        api_key: ENV['FIRE_BASE_API_KEY']
      )
    end
  end
end
