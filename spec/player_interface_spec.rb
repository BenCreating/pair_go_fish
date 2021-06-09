require_relative '../lib/player_interface'

describe 'PlayerInterface' do
  context '#initialize' do
    it 'stores a player and client' do
      interface = PlayerInterface.new('player', 'client')
      expect(interface.player).to eq 'player'
      expect(interface.client).to eq 'client'
    end
  end

  context 'message_client' do
    let!(:server) { TCPServer.new(3336) }
    let!(:user_socket) { TCPSocket.new('localhost', 3336) }

    after(:each) do
      server.close
      user_socket.close
    end

    it 'sends a message to the client' do
      client = server.accept
      interface = PlayerInterface.new('player', client)
      message = 'Hello'
      interface.message_client(message)
      expect(user_socket.gets.chomp).to eq message
    end
  end
end
