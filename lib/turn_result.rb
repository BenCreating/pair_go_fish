require_relative 'playing_card'
require_relative 'player'

class TurnResult
  attr_reader :turn_player, :asked_player, :taken_cards, :public_description, :private_description

  def initialize(turn_player, asked_player, asked_card:, taken_cards: [], fished_for_card: false, completed_set: false)
    @turn_player = turn_player
    @asked_player = asked_player
    @taken_cards = taken_cards
    @public_description = create_public_description(turn_player: turn_player, asked_player: asked_player, asked_card: asked_card, taken_cards: taken_cards, fished_for_card: fished_for_card)
    @private_description = create_private_description(turn_player: turn_player, asked_player: asked_player, asked_card: asked_card, taken_cards: taken_cards, fished_for_card: fished_for_card)
  end

  def create_public_description(turn_player:, asked_player:, asked_card:, taken_cards:, fished_for_card:)
    description = "#{turn_player.name} asks #{asked_player.name} for a #{asked_card.rank}. #{asked_player.name} has #{taken_cards.count}."
    description << " #{turn_player.name} goes fishing." if fished_for_card
    description
  end

  def create_private_description(turn_player:, asked_player:, asked_card:, taken_cards:, fished_for_card:)
    description = "You ask #{asked_player.name} for a #{asked_card.rank}. #{asked_player.name} has #{taken_cards.count}."
    description << " You go fishing and catch a #{taken_cards.first.rank}." if fished_for_card
    description
  end

  def took_cards?
    !(taken_cards.empty?)
  end
end
