App.appearance = App.cable.subscriptions.create("AppearanceChannel", {
  received: (data) ->
    switch data.action
      when "online"
        return $("#available-#{data.user}").html(this.renderOnline(data));
      when "offline"
        return $("##{data.user}-icon").detach()
  renderOnline: (data) ->
    return "<i id='#{data.user}-icon' style='color:green' class='fa fa-circle' aria-hidden='true'></i>";
});
