require_relative 'game_interface'
require 'socket'

class GoFishServer
  attr_reader :server, :clients, :game_interfaces

  MAXIMUM_NUMBER_OF_PLAYERS = 4

  def port_number
    3336
  end

  def initialize
    @clients = []
    @game_interfaces = []
  end

  def start
    @server = TCPServer.new(port_number)
    puts "Server started - port: #{port_number}"
  end

  def stop
    if server
      puts 'Server stopped'
      server.close
    end
  end

  def accept_connection
    client = server.accept_nonblock
    clients << client
    puts 'client connected'
  rescue IO::WaitReadable
    'No client to accept'
  end

  def recieve_message(client)
    sleep(0.1)
    message = client.read_nonblock(1000).chomp
    message
  rescue IO::WaitReadable
    'No message'
  end

  def send_message(client, message)
    client.puts message
  end

  def create_game_if_possible
    if clients.count >= MAXIMUM_NUMBER_OF_PLAYERS
      game_clients = clients.slice!(0, 4)
      game_interfaces << GameInterface.new(game_clients)
    end
  end
end
