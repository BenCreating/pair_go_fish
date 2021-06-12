require_relative '../lib/card_deck'
require_relative '../lib/playing_card'

describe 'CardDeck' do
  it 'stores a specified array of cards' do
    cards = [PlayingCard.new, PlayingCard.new]
    deck = CardDeck.new(cards)
    expect(deck.cards).to match_array cards
  end

  it 'defaults to a standard 52 card deck' do
    deck = CardDeck.new
    expect(deck.cards_left).to eq 52
  end

  it 'adds a card to the deck' do
    cards = [PlayingCard.new, PlayingCard.new]
    new_card = PlayingCard.new('8')
    deck = CardDeck.new(cards)
    deck.add_card(new_card)
    expect(deck.cards.count).to eq 3
    expect(deck.cards.first).to eq new_card
  end

  it 'deals a card from the top of the deck' do
    cards = [PlayingCard.new('3'), PlayingCard.new('2'), PlayingCard.new('A')]
    deck = CardDeck.new(cards)
    dealt_card = deck.deal
    expect(dealt_card.rank).to eq 'A'
  end

  it 'returns the number of cards left in the deck' do
    cards = [PlayingCard.new, PlayingCard.new, PlayingCard.new]
    deck = CardDeck.new(cards)
    expect(deck.cards_left).to eq cards.count
    cards2 = [PlayingCard.new, PlayingCard.new]
    deck2 = CardDeck.new(cards2)
    expect(deck2.cards_left).to eq cards2.count
  end
end
