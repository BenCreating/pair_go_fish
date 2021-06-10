require_relative '../lib/turn'
require_relative '../lib/player'

describe 'Turn' do
  it 'turn is associated with a player' do
    player = Player.new
    turn = Turn.new(player)
    expect(turn.turn_player).to eq player
  end
end
