class Player
  attr_reader :name, :hand

  def initialize(name = 'Alfred', hand = PlayerHand.new([]))
    @name = name
    @hand = hand
  end
end
