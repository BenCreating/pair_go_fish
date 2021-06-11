require_relative '../lib/go_fish_game'
require_relative '../lib/player'

class MockGameInterface
  def pass_question_to_player(question)
    if question == 'pick card'
      'A'
    elsif question == 'pick player'
      'player'
    end
  end
end

describe 'GoFishGame' do
  let(:players) { [Player.new('Player 1'), Player.new('Player 2')] }
  let(:interface) { MockGameInterface.new }

  context '#initialize' do
    it 'stores the players' do
      game = GoFishGame.new(players: players, interface: interface)
      expect(game.players).to match_array players
    end

    it 'creates a deck' do
      game = GoFishGame.new(players: players, interface: interface)
      expect(game.deck).to_not be_nil
    end
  end

  context '#deal_starting_cards' do
    it 'deals the starting number of cards to each player' do
      game = GoFishGame.new(players: players, interface: interface)
      game.deal_starting_cards
      expect(players[0].hand.cards.count).to eq GoFishGame::STARTING_CARD_COUNT
      expect(players[1].hand.cards.count).to eq GoFishGame::STARTING_CARD_COUNT
    end
  end

  context '#pass_question_to_player' do
    it 'passes a request to the game interface for the player to select a card to ask about' do
      game = GoFishGame.new(players: players, interface: interface)
      chosen_card = game.pass_question_to_player('pick card')
      expect(chosen_card).to eq 'A'
    end
  end

  # creates a new turn
  # returns turn result to game interface
  # deal cards to players
end
