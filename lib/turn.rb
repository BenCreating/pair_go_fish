class Turn
  attr_reader :turn_player, :game

  def initialize(player, game)
    @turn_player = player
    @game = game
  end

  def pick_a_card_to_ask_for
    game.pass_question_to_player(turn_player, 'pick card')
  end

  def pick_a_player_to_ask
    game.pass_question_to_player(turn_player, 'pick player')
  end

  def play
    asked_card = pick_a_card_to_ask_for
    asked_player = pick_a_player_to_ask
    taken_cards = asked_player.give_cards_by_rank(asked_card.rank)
    taken_cards.each { |card| turn_player.take_card(card) }
  end
end
