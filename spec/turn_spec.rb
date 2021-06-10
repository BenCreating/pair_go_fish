require_relative '../lib/turn'
require_relative '../lib/player'

class MockGoFishGame
  def pass_question_to_player(question)
    if question == 'pick card'
      'A'
    elsif question == 'pick player'
      'player'
    end
  end
end

describe 'Turn' do
  let(:game) { MockGoFishGame.new }
  let(:player) { Player.new }

  context '#initialize' do
    it 'turn is associated with a player' do
      turn = Turn.new(player, game)
      expect(turn.turn_player).to eq player
    end

    it 'turn is associated with a game' do
      turn = Turn.new(Player.new, game)
      expect(turn.game).to eq game
    end
  end

  context '#pick_a_card_to_ask_for' do
    it 'finds out what card the player wants to ask for' do
      turn = Turn.new(player, game)
      chosen_card = turn.pick_a_card_to_ask_for
      expect(chosen_card).to eq 'A'
    end
  end

  context '#pick_a_player_to_ask' do
    it 'finds out who the player wants to ask for a card' do
      turn = Turn.new(player, game)
      chosen_player = turn.pick_a_player_to_ask
      expect(chosen_player).to eq 'player'
    end
  end
end
