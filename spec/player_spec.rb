require_relative '../lib/player'
require_relative '../lib/player_hand'
require_relative '../lib/playing_card'

describe 'Player' do
  context '#initialize' do
    it 'initializes a player with a name' do
      player = Player.new('Joe')
      expect(player.name).to eq 'Joe'
    end

    it 'reverts to a default name if none is supplied' do
      player = Player.new
      expect(player.name).to_not eq nil
    end

    it 'allows passing in a hand of cards' do
      hand = PlayerHand.new([PlayingCard.new('A'), PlayingCard.new('3')])
      player = Player.new('Fred', hand)
      expect(player.hand).to eq hand
    end
  end

  context '#take_card' do
    it 'adds the specified card to the hand' do
      card = PlayingCard.new('J')
      player = Player.new
      player.take_card(card)
      expect(player.hand.cards.first).to eq card
    end
  end

  context '#give_cards_by_rank' do
    it 'returns all cards of a rank in the hand, and removes them from the hand' do
      matched_cards = [PlayingCard.new('A'), PlayingCard.new('A')]
      unmatched_cards = [PlayingCard.new('3'), PlayingCard.new('7')]
      hand = PlayerHand.new(matched_cards + unmatched_cards)
      player = Player.new('Eliza', hand)
      given_cards = player.give_cards_by_rank('A')
      expect(given_cards).to match_array matched_cards
    end
  end

  context '#find_and_remove_set' do
    let(:set_cards) { [PlayingCard.new('4'), PlayingCard.new('4'), PlayingCard.new('4'), PlayingCard.new('4')] }
    let(:non_set_cards) { non_set_cards = [PlayingCard.new('3'), PlayingCard.new('7')] }
    let(:hand) { PlayerHand.new(set_cards + non_set_cards) }
    let(:player) { player = Player.new('Eliza', hand) }

    it 'removes a card set from the hand and returns the rank of the set' do
      set_rank = player.find_and_remove_set
      expect(set_rank).to eq '4'
      expect(player.hand.cards).to eq non_set_cards
    end

    it 'increases score when a set is removed' do
      player.find_and_remove_set
      expect(player.score).to eq 1
    end
  end

  context '#cards_left' do
    it 'returns the number of cards left in the hand' do
      cards = [PlayingCard.new, PlayingCard.new, PlayingCard.new]
      player = Player.new('Will', PlayerHand.new(cards))
      expect(player.cards_left).to eq cards.count
      cards2 = [PlayingCard.new]
      player2 = Player.new('Jill', PlayerHand.new(cards2))
      expect(player2.cards_left).to eq cards2.count
    end
  end
end
