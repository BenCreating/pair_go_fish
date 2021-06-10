require_relative '../lib/playing_card'

describe 'PlayingCard' do
  it 'stores the rank of a card' do
    rank = '5'
    card = PlayingCard.new(rank)
    expect(card.rank).to eq rank
  end
end
