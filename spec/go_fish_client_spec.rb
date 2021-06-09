require_relative '../lib/go_fish_client'
require_relative '../lib/go_fish_server'

describe 'GoFishClient' do
  let(:server) { GoFishServer.new }
  let!(:clients) { [] }

  before(:each) do
    server.start
  end

  after(:each) do
    server.stop
    clients.each { |client| client.close }
  end

  it 'reads a message from the server' do
    client = GoFishClient.new
    clients << client
    # server accepts client
    # server sends message to client
    # client reads message
    expect(true).to eq false
  end
end
