class Player
  attr_reader :name, :hand

  def initialize(name = 'Alfred', hand = PlayerHand.new([]))
    @name = name
    @hand = hand
  end

  def take_card(card)
    hand.add_card(card)
  end
end
