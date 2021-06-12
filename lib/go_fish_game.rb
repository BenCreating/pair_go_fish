require 'shuffling_deck'
require 'turn'

class GoFishGame
  attr_reader :players, :deck, :interface
  attr_accessor :turn_index

  CARDS_NEEDED_FOR_A_SET = 4
  STARTING_CARD_COUNT = 5

  def initialize(interface:, players:, deck: ShufflingDeck.new)
    @players = players
    @deck = deck
    @interface = interface
    @turn_index = 0
  end

  def deal_starting_cards
    players.each do |player|
      STARTING_CARD_COUNT.times do
        card = deck.deal
        player.take_card(card)
      end
    end
  end

  def play_next_turn
    turn = Turn.new(players[turn_index], self)
    turn_result = turn.play
    increment_turn_index(turn_result.took_cards?)
    turn_result
  end

  def increment_turn_index(did_take_cards = false)
    if did_take_cards == false
      self.turn_index = (turn_index + 1) % players.count
      while deck.cards_left == 0 and players[turn_index].cards_left == 0
        increment_turn_index
      end
    end
  end

  def pass_question_to_player(player, question)
    other_players = players.reject { |other_player| other_player == player }
    interface.pass_question_to_player(player, other_players, question)
  end

  def fish_for_card
    deck.deal
  end
end
