require_relative 'card_deck'
require_relative 'go_fish_game'

class PlayerHand < CardDeck
  def give_cards_by_rank(rank)
    matched_cards = find_cards_by_rank(rank)
    remove_cards_by_rank(rank)
    matched_cards
  end

  def find_and_remove_set
    removed_set = nil
    rank_list = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
    rank_list.each do |rank|
      found_cards = find_cards_by_rank(rank)
      if found_cards.count >= GoFishGame::CARDS_NEEDED_FOR_A_SET
        remove_cards_by_rank(rank)
        removed_set = rank
        break
      end
    end
    removed_set
  end

  private
  def find_cards_by_rank(rank)
    cards.select { |card| card.rank == rank }
  end

  def remove_cards_by_rank(rank)
    cards.select! { |card| card.rank != rank }
  end
end
