class MessageController  < WebsocketRails::BaseController

  def initialize_session
    @message_sent = 0
  end

  def hello
    @count = Viewer.increment_counter
    WebsocketRails[:updates].trigger(:update_count, @count)
  end

  def goodbye
    @count = Viewer.decrement_counter
    WebsocketRails[:updates].trigger(:update_count, @count)
  end

  def post
    name = message[:name]
    text = message[:text]
    @message = "#{name}:   #{text}"
    new_message = Message.new
    new_message.name = name
    new_message.message = text
    new_message.save
    WebsocketRails[:updates].trigger(:update_message, @message)
  end

end
