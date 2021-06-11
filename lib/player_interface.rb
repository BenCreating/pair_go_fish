require_relative 'player'
require 'pry'
class PlayerInterface
  attr_reader :player, :client

  def initialize(client, name = 'Alfred')
    @client = client
    @player = Player.new(name)
  end

  def send_message_to_client(message)
    client.puts message
  end

  def ask_client_a_question_and_wait_for_response(question)
    send_message_to_client(expand_question(question))
    response = nil
    while response == nil do
      response = read_message_from_client
    end
    response
  end

  def read_message_from_client
    sleep(0.1)
    message = client.read_nonblock(1000).chomp
    message
    rescue IO::WaitReadable
  end

  def expand_question(question)
    expanded_question = nil
    if question == 'pick card'
      expanded_question = expand_pick_card_question
    end
    expanded_question
  end

  private

  ASCII_CARD_ROWS = ['┌─┐', '│x│', '└─┘']

  def expand_pick_card_question
    expanded_question = "Which card do you want to ask about?\n"
    player.hand.cards.count.times { |index| expanded_question << " #{index + 1} " }
    expanded_question << "\n"
    3.times { |index| expanded_question << ascii_cards_row(player.hand.cards, index) }
    expanded_question
  end

  def ascii_cards_row(cards, row)
    ascii_card = ''
    cards.each do |card|
      row_characters = ASCII_CARD_ROWS[row]
      row_characters = "│#{card.rank}│" if row == 1
      ascii_card << row_characters
    end
    ascii_card + "\n"
  end
end
