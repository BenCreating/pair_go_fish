require 'shuffling_deck'

class GoFishGame
  attr_reader :players, :deck, :interface

  CARDS_NEEDED_FOR_A_SET = 4
  STARTING_CARD_COUNT = 5

  def initialize(interface:, players:, deck: ShufflingDeck.new)
    @players = players
    @deck = deck
    @interface = interface
  end

  def deal_starting_cards
    players.each do |player|
      STARTING_CARD_COUNT.times do
        card = deck.deal
        player.take_card(card)
      end
    end
  end

  def pass_question_to_player(player, question)
    interface.pass_question_to_player(player, question)
  end
end
