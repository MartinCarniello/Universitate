// $(function(){
//   $(".chat").niceScroll();
// })

function ready() {
  var chat = $(".chat-table-scrollable");
  chat.removeClass('hidden');
  if(chat.length > 0)
    chat.scrollTop(chat[0].scrollHeight);
}

$(document).ready(ready);

$(document).on('turbolinks:load', ready)