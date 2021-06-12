require_relative '../lib/turn_result'
require_relative '../lib/player'
require_relative '../lib/playing_card'

describe 'TurnResult' do
  let(:player_1) { Player.new('Player 1') }
  let(:player_2) { Player.new('Player 2') }
  let(:taken_cards) { [] }
  let(:fished_for_card) { false }
  let(:asked_card) { PlayingCard.new('3') }
  let(:completed_set) { false }
  let(:turn_result) { turn_result = TurnResult.new(player_1, player_2, taken_cards: taken_cards, fished_for_card: fished_for_card, asked_card: asked_card, completed_set: completed_set) }

  context '#initialize' do
    it 'stores the player who took the turn, and the player they asked for a card' do
      expect(turn_result.turn_player).to eq player_1
      expect(turn_result.asked_player).to eq player_2
    end
  end

  context '#public_description' do
    let(:fished_for_card) { true }
    let(:taken_cards) { [PlayingCard.new('K')] }
    let(:turn_result) { TurnResult.new(player_1, player_2, taken_cards: taken_cards, fished_for_card: fished_for_card, asked_card: asked_card, completed_set: completed_set) }

    it 'generates a description, available to all players, of player 1 asking for a card and having to fish' do
      description = turn_result.public_description
      expect(description).to eq "#{player_1.name} asks #{player_2.name} for a #{asked_card.rank}. #{player_2.name} has none. #{player_1.name} goes fishing."
    end

    it 'generates a description, available to all players, of player 2 asking for a card and having to fish' do
      turn_result = TurnResult.new(player_2, player_1, taken_cards: taken_cards, fished_for_card: fished_for_card, asked_card: asked_card, completed_set: completed_set)
      description = turn_result.public_description
      expect(description).to eq "#{player_2.name} asks #{player_1.name} for a #{asked_card.rank}. #{player_1.name} has none. #{player_2.name} goes fishing."
    end

    it 'gives a description, available to all players, of player 1 asking for a card and recieving it' do
      turn_result = TurnResult.new(player_1, player_2, taken_cards: taken_cards, fished_for_card: false, asked_card: asked_card, completed_set: completed_set)
      description = turn_result.public_description
      expect(description).to eq "#{player_1.name} asks #{player_2.name} for a #{asked_card.rank}. #{player_2.name} gives them #{taken_cards.count}."
    end
  end

  context '#private_description' do
    let(:fished_for_card) { true }
    let(:taken_cards) { [PlayingCard.new('Q')] }
    let(:turn_result) { TurnResult.new(player_1, player_2, taken_cards: taken_cards, fished_for_card: fished_for_card, asked_card: asked_card, completed_set: completed_set) }

    it 'generates a description, available to only to player 1, of them asking for a card and having to fish' do
      description = turn_result.private_description
      expect(description).to eq "You ask #{player_2.name} for a #{asked_card.rank}. #{player_2.name} has none. You go fishing and catch a #{taken_cards.first.rank}."
    end

    it 'generates a description, available to only to player 2, of them asking for a card and having to fish' do
      turn_result = TurnResult.new(player_2, player_1, taken_cards: taken_cards, fished_for_card: fished_for_card, asked_card: asked_card, completed_set: completed_set)
      description = turn_result.private_description
      expect(description).to eq "You ask #{player_1.name} for a #{asked_card.rank}. #{player_1.name} has none. You go fishing and catch a #{taken_cards.first.rank}."
    end
  end

  context '#took_cards?' do
    let(:taken_cards) { [PlayingCard.new('A')] }
    let(:turn_result) { TurnResult.new(player_1, player_2, taken_cards: taken_cards, fished_for_card: fished_for_card, asked_card: asked_card, completed_set: completed_set) }

    it 'returns true when the player took cards' do
      expect(turn_result.took_cards?).to eq true
    end
  end
end
