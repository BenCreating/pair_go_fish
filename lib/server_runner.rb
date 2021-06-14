require_relative 'go_fish_server'

server = GoFishServer.new
server.start

loop do
  server.accept_connection
  game_interface = server.create_game_if_possible
  if game_interface
    Thread.new(game_interface) { |game_interface| game_interface.start_game }
  end
end

server.stop
