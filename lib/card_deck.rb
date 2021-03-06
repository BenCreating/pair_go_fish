require_relative 'playing_card'

class CardDeck
  attr_reader :cards

  STANDARD_SUIT_COUNT = 4
  STANDARD_RANKS = (2..10).to_a + ['A', 'J', 'Q', 'K']

  def initialize(cards = default_cards)
    @cards = cards
  end

  def add_card(card)
    cards.unshift(card)
  end

  def deal
    cards.pop
  end

  def cards_left
    cards.count
  end

  private
  def default_cards
    cards = []
    STANDARD_RANKS.each do |rank|
      STANDARD_SUIT_COUNT.times { cards << PlayingCard.new(rank) }
    end
    cards
  end
end
