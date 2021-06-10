class GoFishGame
  attr_reader :players, :deck

  CARDS_NEEDED_FOR_A_SET = 4

  def initialize(players, deck = 'deck')
    @players = players
    @deck = deck
  end
end
