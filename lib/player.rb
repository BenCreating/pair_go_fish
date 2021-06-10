class Player
  attr_reader :name, :hand

  def initialize(name = 'Alfred', hand = PlayerHand.new([]))
    @name = name
    @hand = hand
  end

  def take_card(card)
    hand.add_card(card)
  end

  def give_cards_by_rank(rank)
    hand.give_cards_by_rank(rank)
  end

  def find_and_remove_set
    hand.find_and_remove_set
  end
end
