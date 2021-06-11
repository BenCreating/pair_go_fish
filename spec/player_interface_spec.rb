require_relative '../lib/player_interface'
require_relative '../lib/playing_card'

describe 'PlayerInterface' do
  context '#initialize' do
    it 'stores a client and creates a player for them' do
      interface = PlayerInterface.new('client')
      expect(interface.player).to_not be_nil
      expect(interface.client).to eq 'client'
    end
  end

  context '#send_message_to_client' do
    let!(:server) { TCPServer.new(3336) }
    let!(:user_socket) { TCPSocket.new('localhost', 3336) }

    after(:each) do
      server.close
      user_socket.close
    end

    it 'sends a message to the client' do
      client = server.accept
      interface = PlayerInterface.new(client)
      message = 'Hello'
      interface.send_message_to_client(message)
      expect(user_socket.gets.chomp).to eq message
    end
  end

  context '#read_message_from_client' do
    let!(:server) { TCPServer.new(3336) }
    let!(:user_socket) { TCPSocket.new('localhost', 3336) }

    after(:each) do
      server.close
      user_socket.close
    end

    it 'reads a message from the client' do
      server_socket = server.accept
      interface = PlayerInterface.new(server_socket)
      message = 'Hello'
      user_socket.puts message
      expect(interface.read_message_from_client).to eq message
    end

    it 'rescues the exception when there is no message' do
      server_socket = server.accept
      interface = PlayerInterface.new(server_socket)
      expect(interface.read_message_from_client).to eq nil
    end
  end

  context '#expand_question' do
    let(:interface) { interface = PlayerInterface.new('client') }

    it 'expands "pick card" into a full question with a list of cards' do
      interface.player.take_card(PlayingCard.new('Q'))
      interface.player.take_card(PlayingCard.new('4'))
      expanded_question = interface.expand_question('pick card')
      expect(expanded_question).to eq "Which card do you want to ask about?\n 1  2 \n┌─┐┌─┐\n│4││Q│\n└─┘└─┘\n"
    end
  end
end
