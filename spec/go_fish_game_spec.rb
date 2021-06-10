require_relative '../lib/go_fish_game'
require_relative '../lib/player'

describe 'GoFishGame' do
  context '#initialize' do
    let(:players) { [Player.new('Player 1'), Player.new('Player 2')] }

    it 'stores the players' do
      game = GoFishGame.new(players)
      expect(game.players).to match_array players
    end

    it 'creates a deck' do
      game = GoFishGame.new(players)
      expect(game.deck).to_not be_nil
    end
  end

  # creates a new turn
  # returns turn result to game interface
  # deal cards to players
end
