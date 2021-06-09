require_relative '../lib/game_interface'

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
    end
  end
end
