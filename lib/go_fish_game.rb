class GoFishGame
  attr_reader :players, :deck

  def initialize(players, deck = 'deck')
    @players = players
    @deck = deck
  end
end
