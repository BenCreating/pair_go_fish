class Turn
  attr_reader :turn_player, :game

  def initialize(player, game)
    @turn_player = player
    @game = game
  end

  def pick_a_card_to_ask_for
    game.pass_question_to_player('pick card')
  end

  def pick_a_player_to_ask
    game.pass_question_to_player('pick player')
  end
end
