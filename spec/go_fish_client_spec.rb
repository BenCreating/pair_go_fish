require_relative '../lib/go_fish_client'

describe 'GoFishClient' do
  let!(:server) { TCPServer.new(3336) }
  let!(:clients) { [] }

  after(:each) do
    server.close
    clients.each { |client| client.close }
  end

  context '#recieve_message' do
    it 'reads a message from the server' do
      client = GoFishClient.new
      clients << client
      socket = server.accept
      message = 'Hi'
      socket.puts message
      expect(client.recieve_message).to eq message
    end

    it 'rescues the exception when there is no message' do
      client = GoFishClient.new
      clients << client
      server.accept
      expect(client.recieve_message).to eq 'No message'
    end
  end

  context '#send_message' do
    it 'sends a message to the server' do
      client = GoFishClient.new
      clients << client
      socket = server.accept
      message = 'Hi'
      client.send_message(message)
      expect(socket.gets.chomp).to eq message
    end
  end
end
