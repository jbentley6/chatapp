class MessageController  < WebsocketRails::BaseController
  include ActionView::Helpers::SanitizeHelper

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
    tags = %w(a acronym b strong i em li ul ol h1 h2 h3 h4 h5 h6 blockquote br cite sub sup ins p)
    name  = sanitize(message[:name], tags: tags, attributes: %w(title))
    text = sanitize(message[:text], tags: tags, attributes: %w(title))
    @message = "#{name}:   #{text}"
    new_message = Message.new
    new_message.name = name
    new_message.message = text
    new_message.save
    WebsocketRails[:updates].trigger(:update_message, @message)
  end

end
