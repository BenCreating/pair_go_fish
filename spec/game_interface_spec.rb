require_relative '../lib/game_interface'

describe 'GameInterface' do
  context '#initialize' do
    it 'takes client array as input and associates them with players in a hash' do
      client1 = 'client1'
      client2 = 'client2'
      interface = GameInterface.new([client1, client2])
      expect(interface.clients_to_players[client1]).to_not be nil
    end
  end

  # client/player Hash
  # game
end
