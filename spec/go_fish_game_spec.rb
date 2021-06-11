require_relative '../lib/go_fish_game'
require_relative '../lib/player'
require_relative '../lib/shuffling_deck'
require_relative '../lib/playing_card'

class MockGameInterface
  def pass_question_to_player(player, other_players, question)
    if question == 'pick card'
      player.hand.cards[0]
    elsif question == 'pick player'
      other_players[0]
    end
  end
end

describe 'GoFishGame' do
  let(:players) { [Player.new('Player 1'), Player.new('Player 2'), Player.new('Player 3')] }
  let(:interface) { MockGameInterface.new }
  let(:game) { game = GoFishGame.new(players: players, interface: interface) }

  def player_take_cards(player, cards)
    cards.each do |card|
      player.take_card(card)
    end
  end

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

  context '#play_next_turn' do
    it 'a player takes a turn and it returns the turn result' do
      player_take_cards(players[0], [PlayingCard.new('5')])
      turn_result = game.play_next_turn
      expect(turn_result).to_not eq nil
    end
  end

  context '#fish_for_card' do
    it 'returns the top card of the deck' do
      expected_card = game.deck.cards[-1]
      fished_card = game.fish_for_card
      expect(fished_card). to eq expected_card
    end
  end

  context '#increment_turn_index' do
    it 'increases the turn index by 1' do
      game.increment_turn_index
      expect(game.turn_index).to eq 1
    end

    it 'wraps the turn index back to 0 when it reaches the last player' do
      players.count.times { game.increment_turn_index }
      expect(game.turn_index).to eq 0
    end

    it 'skips player 2 when they have no cards and the deck is empty' do
      player_take_cards(players[0], [PlayingCard.new('5'), PlayingCard.new('4')])
      player_take_cards(players[2], [PlayingCard.new('7')])
      empty_deck_game = GoFishGame.new(players: players, interface: interface, deck: ShufflingDeck.new([]))
      empty_deck_game.increment_turn_index
      expect(empty_deck_game.turn_index).to eq 2
    end

    it 'does not skip player 2 when they have no cards, but the deck has cards' do
      player_take_cards(players[0], [PlayingCard.new('5'), PlayingCard.new('4')])
      player_take_cards(players[2], [PlayingCard.new('7')])
      full_deck_game = GoFishGame.new(players: players, interface: interface, deck: ShufflingDeck.new())
      full_deck_game.increment_turn_index
      expect(full_deck_game.turn_index).to eq 1
    end

    it 'gives the player another turn when they succesfully ask for cards' do
      game.increment_turn_index(true)
      expect(game.turn_index).to eq 0
    end
  end

  context '#pass_question_to_player' do
    let(:game) { GoFishGame.new(players: players, interface: interface) }

    it 'passes a request to the game interface for the player to select a card to ask about' do
      chosen_card = game.pass_question_to_player(players[0], 'pick card')
      expect(chosen_card).to eq players[0].hand.cards[0]
    end

    it 'passes a request to the player interface for the player to select who they want to talk to' do
      chosen_player = game.pass_question_to_player(players[0], 'pick player')
      expect(chosen_player).to eq players[1]
    end
  end
end
