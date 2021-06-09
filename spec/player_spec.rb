require_relative '../lib/player'

describe 'Player' do
  context 'initialize' do
    it 'initializes a player with a name' do
      player = Player.new('Batman')
      expect(player.name).to eq 'Batman'
    end

    it 'reverts to a default name if none is supplied' do
      player = Player.new
      expect(player.name).to_not eq nil
    end
  end
end