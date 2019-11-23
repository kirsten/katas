class Game
  def initialize(rolls = [])
    @rolls = rolls
  end

  def roll(pinfall)
    self.class.new(rolls << pinfall)
  end

  def score
    rolls.sum
  end

  private

  attr_reader :rolls
end
