require_relative '../lib/player_hand'
require_relative '../lib/playing_card'
require_relative '../lib/go_fish_game'

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

  context '#find_and_remove_set' do
    it 'removes a card set from the hand returns the rank of the set' do
      set_cards = [PlayingCard.new('3'), PlayingCard.new('3'), PlayingCard.new('3'), PlayingCard.new('3')]
      non_set_cards = [PlayingCard.new('K'), PlayingCard.new('4')]
      hand = PlayerHand.new(non_set_cards + set_cards)
      removed_set_rank = hand.find_and_remove_set
      expect(removed_set_rank).to eq '3'
      expect(hand.cards).to match_array non_set_cards
    end
  end

  context '#ranks_in_hand' do
    it 'returns an array of all the ranks in the hand' do
      cards = [PlayingCard.new('3'), PlayingCard.new('3'), PlayingCard.new('5'), PlayingCard.new('A')]
      hand = PlayerHand.new(cards)
      found_ranks = hand.ranks_in_hand
      expect(found_ranks).to match_array ['3', '5', 'A']
    end
  end

  # hand:
  # detect and remove books
  # give cards away by rank
end
