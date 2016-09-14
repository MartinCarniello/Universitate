function scrollBottom() {
  var chat = $(".chat-table-scrollable");
  chat.removeClass('hidden');
  if(chat.length > 0)
    chat.scrollTop(chat[0].scrollHeight);
}

function submitMessage() {
  $("#message_message").unbind("keypress").bind({
    keypress: function(event) {
      if(event.which == 13) {
        $("#new_message").submit();
      }
    }
  });

  $("span.answer-btn").unbind("click").bind({
    click: function() {
      $("#new_message").submit();
    }
  });
}

function ready() {
  scrollBottom();
  submitMessage();
}

$(document).ready(ready);
