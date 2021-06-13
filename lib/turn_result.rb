require_relative 'playing_card'
require_relative 'player'

class TurnResult
  attr_reader :turn_player, :asked_player, :taken_cards, :public_description, :private_description

  def initialize(turn_player, asked_player, asked_card:, completed_set: nil, taken_cards: [], fished_for_card: false)
    @turn_player = turn_player
    @asked_player = asked_player
    @taken_cards = taken_cards
    @public_description = create_public_description(turn_player: turn_player, asked_player: asked_player, asked_card: asked_card, taken_cards: taken_cards, fished_for_card: fished_for_card, completed_set: completed_set)
    @private_description = create_private_description(turn_player: turn_player, asked_player: asked_player, asked_card: asked_card, taken_cards: taken_cards, fished_for_card: fished_for_card, completed_set: completed_set)
  end

  def create_public_description(turn_player:, asked_player:, asked_card:, taken_cards:, fished_for_card:, completed_set:)
    description = "#{turn_player.name} asks #{asked_player.name} for a #{asked_card.rank}. #{asked_player.name}"
    description << public_given_cards_or_fishing_description(fished_for_card: fished_for_card, taken_cards: taken_cards)
    description << " #{turn_player.name} has completed the #{completed_set} set!" if completed_set
    description
  end

  def create_private_description(turn_player:, asked_player:, asked_card:, taken_cards:, fished_for_card:, completed_set:)
    description = "You ask #{asked_player.name} for a #{asked_card.rank}. #{asked_player.name}"
    description << private_given_cards_or_fishing_description(fished_for_card: fished_for_card, taken_cards: taken_cards)
    description << " You have completed the #{completed_set} set!" if completed_set
    description
  end

  def took_cards?
    !(taken_cards.empty?)
  end

  private

  def public_given_cards_or_fishing_description(fished_for_card:, taken_cards:)
    if fished_for_card
      " has none. #{turn_player.name} goes fishing."
    else
      " gives them #{taken_cards.count}."
    end
  end

  def private_given_cards_or_fishing_description(fished_for_card:, taken_cards:)
    if fished_for_card
      " has none. You go fishing and catch a #{taken_cards.first.rank}."
    else
      " gives you #{taken_cards.count}."
    end
  end
end
