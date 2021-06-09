require_relative '../lib/go_fish_client'
require_relative '../lib/go_fish_server'

describe 'GoFishClient' do
  let(:server) { GoFishServer.new }
  let!(:clients) { [] }

  before(:each) do
    server.start
  end

  after(:each) do
    server.stop
    clients.each { |client| client.close }
  end

  context '#read_message' do
    it 'reads a message from the server' do
      client = GoFishClient.new
      clients << client
      server.accept_connection
      message = 'Hi'
      server.send_message(server.clients[0], message)
      expect(client.read_message).to eq message
    end

    it 'rescues the exception when there is no message' do
      client = GoFishClient.new
      clients << client
      server.accept_connection
      expect(client.read_message).to eq 'No message'
    end
  end

  context '#send_message' do
    it 'sends a message to the server' do
      client = GoFishClient.new
      clients << client
      server.accept_connection
      message = 'Hi'
      client.send_message(message)
      expect(server.recieve_message(server.clients[0])).to eq message
    end
  end
end
