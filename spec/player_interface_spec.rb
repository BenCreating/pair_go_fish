require_relative '../lib/player_interface'
require_relative '../lib/playing_card'
require_relative '../lib/player_hand'
require_relative '../lib/player'

describe 'PlayerInterface' do
  context '#initialize' do
    it 'stores a client and creates a player for them' do
      interface = PlayerInterface.new('client')
      expect(interface.player).to_not be_nil
      expect(interface.client).to eq 'client'
    end

    it 'set is_ai flag if the client is nil' do
      interface = PlayerInterface.new()
      expect(interface.player).to_not be_nil
      expect(interface.client).to be_nil
      expect(interface.is_ai).to eq true
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
    let(:interface) { PlayerInterface.new('client') }
    let(:hand1) { PlayerHand.new([PlayingCard.new('3'), PlayingCard.new('5')]) }
    let(:hand2) { PlayerHand.new([PlayingCard.new('J')]) }
    let(:players) { [Player.new('Thor', hand1), Player.new('Loki', hand2), Player.new('Odin')] }

    it 'expands "pick card" into a full question with a list of cards' do
      interface.player.take_card(PlayingCard.new('Q'))
      interface.player.take_card(PlayingCard.new('4'))
      expanded_question = interface.expand_question('pick card', players)
      expect(expanded_question).to eq "Which card do you want to ask about?\n 1  2 \n??????????????????\n???4??????Q???\n??????????????????\n"
    end

    it 'expands "pick player" into a full question with a list of players' do
      expanded_question = interface.expand_question('pick player', players)
      expect(expanded_question).to eq "Who do you want to ask?\n1. Thor (2 cards)\n2. Loki (1 card)\n3. Odin (0 cards)"
    end
  end

  context '#interpret_question_response' do
    let(:interface) { interface = PlayerInterface.new }
    let(:cards) { [PlayingCard.new('3'), PlayingCard.new('5')] }
    let(:players) { [Player.new('Thor'), Player.new('Loki'), Player.new('Odin')] }

    it 'returns the card the player picked' do
      cards.reverse.each { |card| interface.player.take_card(card) }
      chosen_card = interface.interpret_question_response('pick card', 0, players)
      expect(chosen_card).to eq cards[0]
    end

    it 'returns the player the player picked' do
      chosen_player = interface.interpret_question_response('pick player', 0, players)
      expect(chosen_player).to eq players[0]
    end
  end
end
