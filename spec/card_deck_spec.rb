require_relative '../lib/card_deck'
require_relative '../lib/playing_card'

describe 'CardDeck' do
  it 'stores an array of cards' do
    cards = [PlayingCard.new, PlayingCard.new]
    deck = CardDeck.new(cards)
    expect(deck.cards).to match_array cards
  end
  # generic:
  # store cards
  # add card

  # hand:
  # detect and remove books
  # give cards away by rank

  # middle deck:
  # deal the top card
  # shuffle
end
