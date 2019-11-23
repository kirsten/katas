class Game
  def initialize(rolls = [])
    @rolls = rolls
  end

  def roll(pinfall)
    self.class.new(rolls << pinfall)
  end

  def score
    if is_spare_frame?(rolls.first(2))
      rolls.sum + rolls[2]
    else
      rolls.sum
    end
  end

  private

  def is_spare_frame?(frame)
    frame.sum == 10
  end

  attr_reader :rolls
end
