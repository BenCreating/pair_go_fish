require_relative '../lib/player_interface'

describe 'PlayerInterface' do
  context '#initialize' do
    it 'stores a client' do
      interface = PlayerInterface.new('client', 'Ben')
      expect(interface.client).to eq 'client'
    end

    it 'creates a player with the correct name' do
      interface = PlayerInterface.new('client', 'Ben')
      expect(interface.player.name).to eq 'Ben'
    end
  end
  # store player
  # store client
  # send message to client
  # read message from client
end
