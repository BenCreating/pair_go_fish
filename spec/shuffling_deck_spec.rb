require_relative '../lib/shuffling_deck'
require_relative '../lib/playing_card'

describe 'ShufflingDeck' do
  def check_in_new_order(deck, unshuffled_deck)
    deck.cards.each.with_index do |card, index|
      if card.rank != unshuffled_deck.cards[index].rank
        return true
      end
    end
    false
  end

  def compare_cards(card1, card2)
  end

  it 'shuffles the order of the cards' do
    unshuffled_deck = ShufflingDeck.new
    deck = ShufflingDeck.new
    deck.shuffle
    deck_in_new_order = check_in_new_order(deck, unshuffled_deck)
    expect(deck_in_new_order).to be true
  end
end
