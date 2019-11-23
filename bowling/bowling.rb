class Game
  def initialize
    @rolls = []
  end

  def roll(pinfall)
    @rolls << pinfall
  end

  def score
    @rolls.sum
  end
end
