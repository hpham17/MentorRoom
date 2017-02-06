// MakeMessageChannel = function(roomId) {
//   // Create the new room channel subscription
//   App.room = App.cable.subscriptions.create({
//     channel: "RoomChannel",
//     roomId: roomId
//   }, {
//     connected: function() {},
//     disconnected: function() {},
//     received: function(data) {
//       return $('#messages').append(data['message']);
//     },
//     speak: function(message, roomId) {
//       return this.perform('speak', {
//         message: message,
//         roomId: roomId
//       });
//     }
//   });
//
//   $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
//    if (event.keyCode === 13) {
//      App.room.speak(event.target.value, roomId);
//      event.target.value = "";
//      event.preventDefault();
//    }
//    return $('#messages').animate({
//      scrollTop: $('#messages')[0].scrollHeight
//    }, 100);
//  });
// };
