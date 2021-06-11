require_relative '../lib/turn'
require_relative '../lib/player'
require_relative '../lib/playing_card'

class MockGoFishGame
  attr_reader :players
  def initialize(players = nil)
    @players = players
  end

  def pass_question_to_player(player, question)
    if question == 'pick card'
      player.hand.cards[0]
    elsif question == 'pick player'
      players[0]
    end
  end
end

describe 'Turn' do
  let(:player) { Player.new }
  before(:each) { player.take_card(PlayingCard.new('A')) }
  let(:game) { MockGoFishGame.new([player]) }

  context '#initialize' do
    it 'turn is associated with a player' do
      turn = Turn.new(player, game)
      expect(turn.turn_player).to eq player
    end

    it 'turn is associated with a game' do
      turn = Turn.new(Player.new, game)
      expect(turn.game).to eq game
    end
  end

  context '#pick_a_card_to_ask_for' do
    it 'finds out what card the player wants to ask for' do
      turn = Turn.new(player, game)
      chosen_card = turn.pick_a_card_to_ask_for
      expect(chosen_card).to eq player.hand.cards[0]
    end
  end

  context '#pick_a_player_to_ask' do
    it 'finds out who the player wants to ask for a card' do
      turn = Turn.new(player, game)
      chosen_player = turn.pick_a_player_to_ask
      expect(chosen_player).to eq player
    end
  end

  context '#play' do
    let(:player_1_cards) { [PlayingCard.new('5'), PlayingCard.new('A')] }
    let(:player_2_cards) { [PlayingCard.new('A')] }
    let(:no_match_cards) { [PlayingCard.new('2'), PlayingCard.new('3')] }
    let(:player1) { Player.new('Player 1') }
    let(:player2) { Player.new('Player 2') }
    let(:players) { [player1, player2] }
    let(:game) { MockGoFishGame.new(players) }

    def player_take_cards(player, cards)
      cards.each do |card|
        player.take_card(card)
      end
    end

    it 'player 2 asks for, and recieves, a card from player 1' do
      player_take_cards(player1, player_1_cards)
      player_take_cards(player2, player_2_cards)
      turn = Turn.new(player2, game)
      turn.play
      expect(player1.hand.cards.count).to eq 1
      expect(player2.hand.cards.count).to eq 2
    end

    it 'player 2 asks for, and does not recieve, a card from player 1' do
      player_take_cards(player1, player_1_cards)
      player_take_cards(player2, no_match_cards)
      turn = Turn.new(player2, game)
      turn.play
      expect(player1.hand.cards.count).to eq 2
      expect(player2.hand.cards.count).to eq 2
    end
  end
end
