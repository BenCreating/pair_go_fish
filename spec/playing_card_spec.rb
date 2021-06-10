require_relative '../lib/playing_card'

describe 'PlayingCard' do
  it 'stores the rank of a card' do
    rank = '5'
    card = PlayingCard.new(rank)
    expect(card.rank).to eq rank
  end

  it 'reverts to a default rank if none is specified' do
    card = PlayingCard.new
    expect(card.rank).to_not be_nil
  end
end
