require_relative 'player'

class GameInterface
  attr_reader :clients_to_players

  def initialize(clients)
    @clients_to_players = associate_clients_with_players(clients)
  end

  def associate_clients_with_players(clients)
    client_players = {}
    clients.each { |client| client_players[client] = Player.new}
    client_players
  end
end
