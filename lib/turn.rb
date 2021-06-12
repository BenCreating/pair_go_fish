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
    turn_player.take_card(game.fish_for_card) if turn_player.cards_left == 0
    taken_cards = ask_for_card
    taken_cards = go_fish_if_necessary(taken_cards)
    pick_up_taken_cards(taken_cards)
    TurnResult.new(turn_player, asked_player, asked_card: asked_card, taken_cards: taken_cards, fished_for_card: fished_for_card, completed_set: false)
  end

  private

  attr_accessor :asked_card, :asked_player, :fished_for_card

  def fish_for_card
    game.fish_for_card
  end

  def ask_for_card
    self.asked_card = pick_a_card_to_ask_for
    self.asked_player = pick_a_player_to_ask
    asked_player.give_cards_by_rank(asked_card.rank)
  end

  def go_fish_if_necessary(taken_cards)
    if taken_cards.empty?
      taken_cards = [fish_for_card]
      self.fished_for_card = true
    else
      self.fished_for_card = false
    end
    taken_cards
  end

  def pick_up_taken_cards(taken_cards)
    taken_cards.each { |card| turn_player.take_card(card) }
  end
end
