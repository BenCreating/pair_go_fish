class TurnResult
  attr_reader :turn_player, :asked_player

  def initialize(turn_player, asked_player)
    @turn_player = turn_player
    @asked_player = asked_player
  end

  def public_description
    'Henry asks Margaret for a 5. Margaret has 0. Henry goes fishing.'
  end

  def private_description
    'You ask Margaret for a 5. Margaret has 0. You go fishing and catch a 7.'
  end
end
