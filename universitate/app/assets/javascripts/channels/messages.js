App.messages = App.cable.subscriptions.create({channel: 'MessagesChannel', conversation: $(location.pathname.split("/")).last()[0]}, {  
  received: function(data) {
    $('.chat-body .answer').last().after(this.renderMessage(data));
    scrollBottom();
  },

  renderMessage: function(data) {
    return '<div class="answer ' + this.cssClass(data.username) + '"><div class="avatar"></div><div class="name">' + this.displayUsername(data.username) + '</div><div class="text">' + data.message + '</div><div class="time">' + data.datetime + '</div></div>';
  },

  cssClass: function(username) {
    return this.currentUserSender(username, 'right', 'left');
  },

  displayUsername: function(username) {
    return this.currentUserSender(username, 'Yo', username);
  },

  currentUserSender: function(username, ifTrue, ifFalse) {
    return $("#username").data("username") == username ? ifTrue : ifFalse;
  }
});
