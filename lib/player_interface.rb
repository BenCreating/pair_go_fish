require_relative 'player'

class PlayerInterface
  attr_reader :player, :client, :is_ai

  def initialize(client = nil, name = 'Alfred')
    @client = client
    @player = Player.new(name)
    @is_ai = client.nil?
  end

  def send_message_to_client(message)
    client.puts message
  end

  def ask_a_question_and_wait_for_response(question, other_players)
    if is_ai == false
      response = ask_client_a_question_and_wait_for_response(question, other_players)
    else
      response = ask_ai_a_question_and_return_response(question, other_players)
    end
    interpret_question_response(question, response, other_players)
  end

  def ask_client_a_question_and_wait_for_response
    send_message_to_client(expand_question(question, other_players))
    response = nil
    while response == nil do
      response = read_message_from_client
    end
    response
  end

  def ask_ai_a_question_and_return_response(question, other_players)
    return '0'
  end

  def interpret_question_response(question, response, other_players)
    if response.to_i.to_s == response
      process_response(question, response.to_i, other_players)
    else
      ask_a_question_and_wait_for_response(question, other_players)
    end
  end

  def read_message_from_client
    sleep(0.1)
    message = client.read_nonblock(1000).chomp
    message
    rescue IO::WaitReadable
  end

  def expand_question(question, other_players)
    expanded_question = nil
    if question == 'pick card'
      expanded_question = expand_pick_card_question
    elsif question == 'pick player'
      expanded_question = expand_pick_player_question(other_players)
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

  def expand_pick_player_question(other_players)
    expanded_question = "Who do you want to ask?\n"
    other_players.each.with_index do |player, index|
      expanded_question << "#{index + 1}. #{player.name} (#{card_count_string(player.hand.cards.count)})\n"
    end
    expanded_question.chomp
  end

  def card_count_string(count)
    if count == 1
      "#{count} card"
    else
      "#{count} cards"
    end
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

  def process_response(question, response, other_players)
    if question == 'pick card'
      player.hand.cards[response]
    elsif question == 'pick player'
      other_players[response]
    end
  end
end
