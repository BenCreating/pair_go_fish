require_relative 'card_deck'
require_relative 'go_fish_game'

class PlayerHand < CardDeck
  def give_cards_by_rank(rank)
    matched_cards = find_cards_by_rank(rank)
    remove_cards_by_rank(rank)
    matched_cards
  end

  def find_and_remove_set
    ranks_in_hand.each do |rank|
      if find_cards_by_rank(rank).count >= GoFishGame::CARDS_NEEDED_FOR_A_SET
        remove_cards_by_rank(rank)
        return rank
      end
    end
    nil
  end

  def ranks_in_hand
    rank_list = []
    cards.each { |card| rank_list << card.rank }
    rank_list.uniq!
    rank_list
  end

  private
  def find_cards_by_rank(rank)
    cards.select { |card| card.rank == rank }
  end

  def remove_cards_by_rank(rank)
    cards.select! { |card| card.rank != rank }
  end
end
