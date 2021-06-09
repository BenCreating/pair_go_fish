require_relative 'player'

class PlayerInterface
  attr_reader :player, :client

  def initialize(client, name = 'Alfred')
    @client = client
    @player = Player.new(name)
  end

  def send_message_to_client(message)
    client.puts message
  end
end
