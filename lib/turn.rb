class Turn
  attr_reader :turn_player, :game

  def initialize(player, game)
    @turn_player = player
    @game = game
  end
end
