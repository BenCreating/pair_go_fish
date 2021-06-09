require_relative '../lib/turn_result'

describe 'TurnResult' do
  context '#initialize' do
    it 'stores the player who took the turn' do
      turn_result = TurnResult.new('player')
      expect(turn_result.turn_player).to eq 'player'
    end
  end

  context '#public_description' do
    it 'generates a description of the turn that is available to all players' do
      turn_result = TurnResult.new('player')
      description = turn_result.public_description
      expect(description).to eq 'Henry asks Margaret for a 5. Margaret has 0. Henry goes fishing.'
    end
  end

  context '#private_description' do
    it 'generates a description of the turn that is available to only the player who\'s turn it is' do
      turn_result = TurnResult.new('player')
      description = turn_result.private_description
      expect(description).to eq 'You ask Margaret for a 5. Margaret has 0. You go fishing and catch a 7.'
    end
  end
end
