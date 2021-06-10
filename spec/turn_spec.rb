require_relative '../lib/turn'
require_relative '../lib/player'

class MockGoFishGame

end

describe 'Turn' do
  let(:game) { MockGoFishGame.new }

  it 'turn is associated with a player' do
    player = Player.new
    turn = Turn.new(player, game)
    expect(turn.turn_player).to eq player
  end
end
