require_relative '../lib/card_deck'
require_relative '../lib/playing_card'

describe 'CardDeck' do
  it 'stores an array of cards' do
    cards = [PlayingCard.new, PlayingCard.new]
    deck = CardDeck.new(cards)
    expect(deck.cards).to match_array cards
  end

  it 'defaults to a standard 52 card deck' do
    deck = CardDeck.new
    expect(deck.cards.count).to eq 52
  end

  # it 'can add a card to the deck' do
  #   cards = [PlayingCard.new, PlayingCard.new]
  #   deck = CardDeck.new(cards)
  #   expect(deck.cards).to match_array cards
  # end

  # generic:
  # add card

  # hand:
  # detect and remove books
  # give cards away by rank

  # middle deck:
  # deal the top card
  # shuffle
end
