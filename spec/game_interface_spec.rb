require_relative '../lib/game_interface'
require_relative '../lib/player_interface'
require_relative '../lib/turn_result'

describe 'GameInterface' do
  context '#initialize' do
    it 'takes an array of clients as input and creates a player interface for each' do
      client1 = 'client1'
      client2 = 'client2'
      interface = GameInterface.new([client1, client2])
      expect(interface.player_interfaces[0].client).to eq client1
      expect(interface.player_interfaces[0].player).to_not be_nil
      expect(interface.player_interfaces[1].client).to eq client2
      expect(interface.player_interfaces[1].player).to_not be_nil
    end
  end

  context 'describe_result_to_clients' do
    let!(:server) { TCPServer.new(3336) }
    let!(:clients) { [] }

    def create_clients_and_sockets(count)
      client_socket_array = []
      count.times do
        client_socket_array << create_and_accept_client
      end
      client_socket_array
    end

    def create_and_accept_client
      client = TCPSocket.new('localhost', 3336)
      clients << client
      socket = server.accept
      {client: client, socket: socket}
    end

    after(:each) do
      server.close
      clients.each do |client|
        client.close if client
      end
    end

    it 'sends the private result description to the player who took the turn' do
      clients_and_sockets = create_clients_and_sockets(3)
      interface = GameInterface.new([clients_and_sockets[0][:socket], clients_and_sockets[1][:socket], clients_and_sockets[2][:socket]])
      turn_player = interface.player_interfaces[0].player
      result = TurnResult.new(turn_player)
      interface.describe_result_to_clients(result)
      expect(clients_and_sockets[0][:client].gets.chomp).to eq result.private_description
    end

    it 'sends the public result description to all players who did not take the turn' do
      clients_and_sockets = create_clients_and_sockets(3)
      interface = GameInterface.new([clients_and_sockets[0][:socket], clients_and_sockets[1][:socket], clients_and_sockets[2][:socket]])
      turn_player = interface.player_interfaces[0].player
      result = TurnResult.new(turn_player)
      interface.describe_result_to_clients(result)
      expect(clients_and_sockets[1][:client].gets.chomp).to eq result.public_description
      expect(clients_and_sockets[2][:client].gets.chomp).to eq result.public_description
    end
  end
end
