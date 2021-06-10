require_relative '../lib/go_fish_game'
require_relative '../lib/player'

describe 'GoFishGame' do
  let(:players) { [Player.new('Player 1'), Player.new('Player 2')] }
  
  context '#initialize' do
    it 'stores the players' do
      game = GoFishGame.new(players)
      expect(game.players).to match_array players
    end

    it 'creates a deck' do
      game = GoFishGame.new(players)
      expect(game.deck).to_not be_nil
    end
  end

  context '#deal_starting_cards' do
    it 'deals the starting number of cards to each player' do
      game = GoFishGame.new(players)
      game.deal_starting_cards
      expect(players[0].hand.cards.count).to eq GoFishGame::STARTING_CARD_COUNT
      expect(players[1].hand.cards.count).to eq GoFishGame::STARTING_CARD_COUNT
    end
  end

  # creates a new turn
  # returns turn result to game interface
  # deal cards to players
end
