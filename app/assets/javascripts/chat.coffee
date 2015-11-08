$(document).ready ->
  dispatcher = new WebSocketRails('localhost:3000/websocket')
  channel = dispatcher.subscribe('updates')

  dispatcher.on_open = (data) ->
    console.log 'Connection has been established: ', data
    dispatcher.trigger 'hello'
    return

  channel.bind 'update_count', (count) ->
    $('#count').text "Users Online: #{count}"
    return

  channel.bind 'update_message', (message) ->
    $('#chat_list').append("<li>#{message}</li>")
    d = $('.chat-panel')
    d.scrollTop(d.prop("scrollHeight"))
    return


  $('#send').on 'click', ->
    text = $('#message').val()
    name = $('#name').val()
    message =
      name: name
      text: text
    dispatcher.trigger 'post', message
    $('#message').val('')
    return

  d = $('.chat-panel')
  d.scrollTop(d.prop("scrollHeight"))
  return
