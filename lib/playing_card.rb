class PlayingCard
  attr_reader :rank

  def initialize(rank = '3')
    @rank = rank
  end
end
