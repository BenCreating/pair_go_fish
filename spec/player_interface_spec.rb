require_relative '../lib/player_interface'

describe 'PlayerInterface' do
  context '#initialize' do
    it 'stores a player and client' do
      interface = PlayerInterface.new('player', 'client')
      expect(interface.player).to eq 'player'
      expect(interface.client).to eq 'client'
    end
  end
end
