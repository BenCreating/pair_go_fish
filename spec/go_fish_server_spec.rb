require_relative '../lib/go_fish_server.rb'

describe 'GoFishServer' do
  let(:server) { GoFishServer.new }
  let(:clients) { [] }

  def create_and_accept_client
    client = TCPSocket.new('localhost', server.port_number)
    clients << client
    server.accept_connection
    client
  end

  before(:each) do
    server.start
  end

  after(:each) do
    server.stop
    clients.each { |client| client.close }
  end

  it 'returns the port number' do
    expect(server.port_number).to eq 3336
  end

  context '#accept_connection' do
    it 'accepts a client' do
      client = create_and_accept_client
      expect(server.clients.count).to eq 1
    end

    it 'rescue no client error' do
      expect(server.accept_connection).to eq 'No client to accept'
    end
  end

  context '#recieve_message' do
    it 'reads a message from a socket' do
      client = create_and_accept_client
      message = 'Hello'
      client.puts message
      expect(server.recieve_message(server.clients[0])).to eq message
    end

    it 'rescues the exception if there is no message' do
      client = create_and_accept_client
      expect(server.recieve_message(server.clients[0])).to eq 'No message'
    end
  end

  context '#send_message' do
    it 'sends a message to a client' do
      client = create_and_accept_client
      message = 'Hello'
      server.send_message(server.clients[0], message)
      expect(client.gets.chomp).to eq message
    end
  end

  context '#create_game_if_possible' do
    it 'creates a game when the maximum player count is met' do
      GoFishServer::MAXIMUM_NUMBER_OF_PLAYERS.times { create_and_accept_client }
      server.create_game_if_possible
      expect(server.game_interfaces.count).to eq 1
      expect(server.clients.count).to eq 0
    end
  end
end
