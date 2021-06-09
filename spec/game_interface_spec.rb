require_relative '../lib/game_interface'
require_relative '../lib/turn_result'

describe 'GameInterface' do
  context '#initialize' do
    it 'takes client array as input and associates them with players in an array of hashes' do
      client1 = 'client1'
      client2 = 'client2'
      interface = GameInterface.new([client1, client2])
      expect(interface.clients_to_players[0][:client]).to eq client1
      expect(interface.clients_to_players[0][:player]).to_not be_nil
      expect(interface.clients_to_players[1][:client]).to eq client2
      expect(interface.clients_to_players[1][:player]).to_not be_nil
    end
  end

  context '#associate_clients_with_players' do
    let(:client1) { 'client1' }
    let(:client2) { 'client1' }

    it 'returns an array of hashes that associate clients and players' do
      interface = GameInterface.new([])
      clients_to_players = interface.associate_clients_with_players([client1, client2])
      expect(clients_to_players[0][:client]).to eq client1
      expect(clients_to_players[0][:player]).to_not be_nil
      expect(clients_to_players[1][:client]).to eq client2
      expect(clients_to_players[1][:player]).to_not be_nil
    end
  end

  context 'describe_result_to_clients' do
    let!(:server) { TCPServer.new(3336) }
    let!(:clients) { [] }

    def create_client_and_socket_array(count)
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
      clients_and_sockets = create_client_and_socket_array(3)
      interface = GameInterface.new([clients_and_sockets[0][:socket], clients_and_sockets[1][:socket], clients_and_sockets[2][:socket]])
      result = TurnResult.new(interface.clients_to_players[0][:player])
      interface.describe_result_to_clients(result)
      expect(clients_and_sockets[0][:client].gets.chomp).to eq result.private_description
    end

    it 'sends the public result description to all players who did not take the turn' do
      clients_and_sockets = create_client_and_socket_array(3)
      interface = GameInterface.new([clients_and_sockets[0][:socket], clients_and_sockets[1][:socket], clients_and_sockets[2][:socket]])
      result = TurnResult.new(interface.clients_to_players[0][:player])
      interface.describe_result_to_clients(result)
      expect(clients_and_sockets[1][:client].gets.chomp).to eq result.public_description
      expect(clients_and_sockets[2][:client].gets.chomp).to eq result.public_description
    end
  end
end
