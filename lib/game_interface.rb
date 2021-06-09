require_relative 'player'

class GameInterface
  attr_reader :clients_to_players

  def initialize(clients)
    @clients_to_players = {}
    clients.each do |client|
      clients_to_players[client] = Player.new
    end
  end
end
