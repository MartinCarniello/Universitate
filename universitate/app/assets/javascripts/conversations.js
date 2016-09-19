//= require ./channels/conversations.js

function scrollBottom() {
  if($('.chat-message').size() > 0){
    $('.chat-message').slimScroll({
      scrollTo: $('.chat-message')[0].scrollHeight
    });
  }

}

(function() {
  function scrollableChat() {
    $('.chat-message').slimScroll({
      height: '100%',
      start: 'bottom'
    });
  }

  function submitMessage() {
    $("#chat-message").unbind("keypress").bind({
      keypress: function(event) {
        if(event.which == 13) {
          $("#message_message").val($("#chat-message").val());
          $("#new_message").submit();
        }
      }
    });

    $("#message-button").unbind("click").bind({
      click: function() {
        $("#message_message").val($("#chat-message").val());
        $("#new_message").submit();
      }
    });
  }

  function ready() {
    scrollableChat();
    scrollBottom();
    submitMessage();
  }

  $(document).ready(ready);
})();
