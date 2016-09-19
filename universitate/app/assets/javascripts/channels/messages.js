App.messages = App.cable.subscriptions.create({channel: 'MessagesChannel', conversation: $(location.pathname.split("/")).last()[0]}, {  
  received: function(data) {
    $('li.clearfix').last().after(this.renderMessage(data));
    scrollBottom();
  },

  renderMessage: function(data) {
    return '<li class="clearfix ' + this.cssClass(data.username, 'right', 'left') + '"><span class="chat-img pull-' + this.cssClass(data.username, 'right', 'left') + '"></span><div class="chat-body clearfix"><div class="header"><strong class="primary-font ' + this.cssClass(data.username, 'pull-right', '') + '">' + this.displayUsername(data.username) + '</strong><small class="text-muted ' + this.cssClass(data.username, '', 'pull-right') + '"><i class="fa fa-clock-o"></i>' + data.datetime + '</small></div><p class=' + this.cssClass(data.username, 'pull-right', 'pull-left') + '>' + data.message + '</p></div></li>';
  },

  cssClass: function(username, classOne, classTwo) {
    return this.currentUserSender(username, classOne, classTwo);
  },

  displayUsername: function(username) {
    return this.currentUserSender(username, 'Yo', username);
  },

  currentUserSender: function(username, ifTrue, ifFalse) {
    return $("#username").data("username") == username ? ifTrue : ifFalse;
  }
});