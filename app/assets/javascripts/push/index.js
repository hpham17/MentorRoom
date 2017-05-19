import {ready as companion} from "push/companion";
import {ready, sendNotification} from "push/app";

$(document).ready(companion);
$(document).ready(ready);
$(document).on('page:load.push-simple', ready);
$(document).on('page:before-change.push-simple', function() {
  $(document).unbind('page:load.push-simple');
});

$(document).on('page:send-notification.push-simple', sendNotification);
$('.send-notification-button').on('click', sendNotification);

console.log("Push simple");
