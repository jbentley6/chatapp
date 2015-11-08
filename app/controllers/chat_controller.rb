class ChatController < ApplicationController

  def index
    @messages = Message.last(50)
  end

end
