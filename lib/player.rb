require_relative 'player_hand'

class Player
  attr_reader :name, :hand, :score

  def initialize(name = 'Alfred', hand = PlayerHand.new([]), score = 0)
    @name = name
    @hand = hand
    @score = 0
  end

  def take_card(card)
    hand.add_card(card)
  end

  def give_cards_by_rank(rank)
    hand.give_cards_by_rank(rank)
  end

  def find_and_remove_set
    found_set = hand.find_and_remove_set
    self.score += 1 if found_set
    found_set
  end

  def cards_left
    hand.cards_left
  end

  private

  attr_writer :score
end
