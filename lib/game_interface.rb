require_relative 'player'
require_relative 'player_interface'
require_relative 'go_fish_game'

require 'pry'

class GameInterface
  attr_reader :player_interfaces, :game

  def initialize(clients, interface_overrides = nil)
    @player_interfaces = new_player_interfaces_or_overrides(clients, interface_overrides)
    game_players = player_interfaces.map { |interface| interface.player }
    @game = GoFishGame.new(interface: self, players: game_players, deck: ShufflingDeck.new)
  end

  def describe_result_to_clients(result)
    player_interfaces.each do |interface|
      if interface.player == result.turn_player
        interface.send_message_to_client(result.private_description)
      else
        interface.send_message_to_client(result.public_description)
      end
    end
  end

  def pass_question_to_player(player, all_players, question)
    target_player_interface = (player_interfaces.select { |interface| interface.player == player }).pop
    target_player_interface.ask_a_question_and_wait_for_response(question, all_players)
  end

  def start_game
    play_game_loop
  end

  private

  def new_player_interfaces_or_overrides(clients, interface_overrides)
    interface_array = []
    if !interface_overrides
      clients.each { |client| interface_array << PlayerInterface.new(client) }
    else
      clients.each.with_index { |client, index| interface_array << interface_overrides[index] }
    end
    interface_array
  end

  def play_game_loop
    while !game.winners
      game.play_next_turn
    end
    player_interfaces.each { |interface| interface.send_message_to_client('Game over') }
  end
end
