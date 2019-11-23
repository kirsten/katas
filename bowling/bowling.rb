class Game
  def initialize(rolls = [])
    @rolls = rolls
  end

  def roll(pinfall)
    self.class.new(rolls << pinfall)
  end

  def score
    running_score = 0

    while rolls.any?
      frame_score = is_spare_frame?(rolls.take(2)) ? rolls.take(3).sum : rolls.take(2).sum
      running_score += frame_score
      rolls.shift(2)
    end

    running_score
  end

  private

  def is_spare_frame?(frame)
    frame.sum == 10
  end

  attr_reader :rolls
end
