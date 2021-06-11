require_relative '../lib/turn_result'
require_relative '../lib/player'
require_relative '../lib/playing_card'

describe 'TurnResult' do
  let(:player_1) { Player.new('Player 1') }
  let(:player_2) { Player.new('Player 2') }
  let(:turn_result) { turn_result = TurnResult.new(player_1, player_2) }

  context '#initialize' do
    it 'stores the player who took the turn, and the player they asked for a card' do
      expect(turn_result.turn_player).to eq player_1
      expect(turn_result.asked_player).to eq player_2
    end
  end

  context '#public_description' do
    it 'generates a description of the turn that is available to all players' do
      description = turn_result.public_description
      expect(description).to eq 'Henry asks Margaret for a 5. Margaret has 0. Henry goes fishing.'
    end
  end

  context '#private_description' do
    it 'generates a description of the turn that is available to only the player who\'s turn it is' do
      description = turn_result.private_description
      expect(description).to eq 'You ask Margaret for a 5. Margaret has 0. You go fishing and catch a 7.'
    end
  end

  context '#took_cards?' do
    it 'returns true when the player took cards' do
      turn_result = TurnResult.new(player_1, player_2, taken_cards: [PlayingCard.new('A')])
      expect(turn_result.took_cards?).to eq true
    end
  end
end
