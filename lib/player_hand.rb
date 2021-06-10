require_relative 'card_deck'

class PlayerHand < CardDeck
  def give_cards_by_rank(rank)
    matched_cards = find_cards_by_rank(rank)
    remove_cards_by_rank(rank)
    matched_cards
  end

  private
  def find_cards_by_rank(rank)
    cards.select { |card| card.rank == rank }
  end

  def remove_matched_cards_from_deck(rank)
    cards.select! { |card| card.rank != rank }
  end
end
