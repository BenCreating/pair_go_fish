require_relative 'player'
require_relative 'player_interface'

require 'pry'

class GameInterface
  attr_reader :player_interfaces

  def initialize(clients)
    @player_interfaces = []
    clients.each do |client|
      player_interfaces << PlayerInterface.new(client)
    end
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
end
