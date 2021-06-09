require_relative 'player'

class GameInterface
  attr_reader :clients_to_players

  def initialize(clients)
    @clients_to_players = associate_clients_with_players(clients)
  end

  def associate_clients_with_players(clients)
    client_players = []
    clients.each do |client|
      client_players << {client: client, player: Player.new}
    end
    client_players
  end

  def describe_result_to_clients(result)
    describe_to_turn_player(result)
    describe_to_other_players(result)
  end

  private
  def describe_to_turn_player(result)
    turn_player_client_hash = clients_to_players.select { |client_player_hash| client_player_hash[:player] == result.turn_player}
    turn_client = turn_player_client_hash.pop[:client]
    turn_client.puts result.private_description
  end

  def describe_to_other_players(result)
    turn_player_client_hashes = clients_to_players.select { |client_player_hash| client_player_hash[:player] != result.turn_player}
    turn_clients = []
    turn_player_client_hashes.each do |hash|
      turn_client = hash[:client]
      turn_client.puts result.public_description
    end
  end
end
