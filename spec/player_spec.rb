require_relative '../lib/player'
require_relative '../lib/player_hand'
require_relative '../lib/playing_card'

describe 'Player' do
  context 'initialize' do
    it 'initializes a player with a name' do
      player = Player.new('Joe')
      expect(player.name).to eq 'Joe'
    end

    it 'reverts to a default name if none is supplied' do
      player = Player.new
      expect(player.name).to_not eq nil
    end

    it 'allows passing in a hand of cards' do
      hand = PlayerHand.new([PlayingCard.new('A'), PlayingCard.new('3')])
      player = Player.new('Fred', hand)
      expect(player.hand).to eq hand
    end
  end
end
