class Game
  def initialize(rolls = [])
    @rolls = rolls
  end

  def roll(pinfall)
    self.class.new(rolls << pinfall)
  end

  def score
    if rolls.first(2).sum == 10
      rolls.sum + rolls[2]
    else
      rolls.sum
    end
  end

  private

  attr_reader :rolls
end
