require_relative '../lib/go_fish_server.rb'
require_relative '../lib/go_fish_client.rb'

describe 'GoFishServer' do
  let(:server) { GoFishServer.new }

  before(:each) do
    server.start
  end

  after(:each) do
    server.stop
  end

  it 'returns the port number' do
    expect(server.port_number).to eq 3336
  end

  context '#accept_connection' do
    it 'accepts a client' do
      client = GoFishClient.new
      server.accept_connection
      expect(server.clients.count).to eq 1
      client.close
      # TODO ask how to confirm that the client is actually the one I expect without hanging
    end

    it 'rescue no client error' do
      expect(server.accept_connection).to eq 'No client to accept'
    end
  end

  context '#recieve_message' do
    it 'reads a message from a socket' do
      client = GoFishClient.new
      server.accept_connection
      message = 'Hello'
      client.socket.puts message
      expect(server.recieve_message(server.clients[0])).to eq message
      client.close
    end

    it 'rescues the exception if there is no message' do
      client = GoFishClient.new
      server.accept_connection
      expect(server.recieve_message(server.clients[0])).to eq 'No message'
      client.close
    end
  end

  context '#send_message' do
    it 'sends a message to a client' do
      client = TCPSocket.new('localhost', server.port_number)
      server.accept_connection
      message = 'Hello'
      server.send_message(server.clients[0], message)
      expect(client.gets.chomp).to eq message
      client.close
    end
  end
end
