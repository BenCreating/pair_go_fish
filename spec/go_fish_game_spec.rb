require_relative '../lib/go_fish_game'
require_relative '../lib/player'

class MockGameInterface
  def pass_question_to_player(player, other_players, question)
    if question == 'pick card'
      'A'
    elsif question == 'pick player'
      other_players
    end
  end
end

describe 'GoFishGame' do
  let(:players) { [Player.new('Player 1'), Player.new('Player 2'), Player.new('Player 3')] }
  let(:interface) { MockGameInterface.new }
  let(:game) { game = GoFishGame.new(players: players, interface: interface) }

  context '#initialize' do
    it 'stores the players' do
      expect(game.players).to match_array players
    end

    it 'creates a deck' do
      expect(game.deck).to_not be_nil
    end
  end

  context '#deal_starting_cards' do
    it 'deals the starting number of cards to each player' do
      game.deal_starting_cards
      expect(players[0].hand.cards.count).to eq GoFishGame::STARTING_CARD_COUNT
      expect(players[1].hand.cards.count).to eq GoFishGame::STARTING_CARD_COUNT
    end
  end


  context '#increment_turn_index' do
    it 'increases the turn index by' do
      game.increment_turn_index
      expect(game.turn_index).to eq 1
    end

    it 'wraps the turn index back to 0 when it reaches the last player' do
      players.count.times { game.increment_turn_index }
      expect(game.turn_index).to eq 0
    end
  end

  context '#pass_question_to_player' do
    let(:game) { GoFishGame.new(players: players, interface: interface) }

    it 'passes a request to the game interface for the player to select a card to ask about' do
      chosen_card = game.pass_question_to_player(players[0], 'pick card')
      expect(chosen_card).to eq 'A'
    end

    it 'passes a request to the player interface for the player to select who they want to talk to' do
      chosen_card = game.pass_question_to_player(players[0], 'pick player')
      expect(chosen_card).to match_array [players[1], players[2]]
    end
  end
end
