App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  received: (data) ->
    $("#notify-icon").addClass('red-icon')
    return $('.lg-body').prepend(this.renderMessage(data));

  renderMessage: (data) ->
    return "<a href='/chatrooms/#{data.topic}' class='list-group-item media notifications' data-message-id='#{data.id}'>
            <div class='media-body'>
              <div class='lgi-heading'>#{data.user}</div>
              <p class='lgi-text'>#{data.content}</p>
            </div></a>"
});
