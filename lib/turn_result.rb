class TurnResult
  attr_reader :turn_player, :asked_player, :taken_cards

  def initialize(turn_player, asked_player, taken_cards: [])
    @turn_player = turn_player
    @asked_player = asked_player
    @taken_cards = taken_cards
  end

  def public_description
    'Henry asks Margaret for a 5. Margaret has 0. Henry goes fishing.'
  end

  def private_description
    'You ask Margaret for a 5. Margaret has 0. You go fishing and catch a 7.'
  end

  def took_cards?
    !(taken_cards.empty?)
  end
end
