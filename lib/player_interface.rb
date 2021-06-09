class PlayerInterface
  attr_reader :player, :client

  def initialize(player, client)
    @player = player
    @client = client
  end

  def message_client(message)
    client.puts message
  end
end
