require_relative '../lib/player_hand'
require_relative '../lib/playing_card'

describe 'PlayerHand' do
  context '#give_cards_by_rank' do
    it 'removes and returns all cards of a specified rank in the hand' do
      matching_cards = [PlayingCard.new('7'), PlayingCard.new('7')]
      non_matching_cards = [PlayingCard.new('K'), PlayingCard.new('4')]
      hand = PlayerHand.new(non_matching_cards + matching_cards)
      given_cards = hand.give_cards_by_rank('7')
      expect(given_cards).to match_array matching_cards
      expect(hand.cards).to match_array non_matching_cards
    end
  end
end
