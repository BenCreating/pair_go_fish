require 'shuffling_deck'

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


  def increment_turn_index
    self.turn_index = (turn_index + 1) % players.count
    while deck.cards.count == 0 and players[turn_index].hand.cards.count == 0
      increment_turn_index
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
