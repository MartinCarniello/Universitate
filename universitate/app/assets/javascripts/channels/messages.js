App.messages = App.cable.subscriptions.create({channel: 'MessagesChannel', conversation: $(location.pathname.split("/")).last()[0]}, {  
  received: function(data) {
    $('li.clearfix').last().after(this.renderMessage(data));
    scrollBottom();
  },

  renderMessage: function(data) {
    return '<li class="clearfix ' + this.cssClass(data.username) + '"><span class="chat-img pull-' + this.cssClass(data.username) + '"><img src="/empty_user.png" alt="Empty user"></span><div class="chat-body clearfix"><div class="header"><strong class="primary-font">' + this.displayUsername(data.username) + '</strong><small class="pull-right text-muted"><i class="fa fa-clock-o"></i>' + data.datetime + '</small></div><p>' + data.message + '</p></div></li>';
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