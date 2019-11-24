class Game
  def initialize(rolls = [])
    @rolls = rolls
  end

  def roll(pinfall)
    self.class.new(rolls << pinfall)
  end

  def score
    running_score = 0
    frame_number = 1

    while rolls.any?
      frame_score = 0
      if frame_number == 10
        frame_score += rolls.sum
        rolls.shift(rolls.length)
      elsif is_spare_frame?(rolls.take(2))
        frame_score += rolls.take(3).sum
        rolls.shift(2)
      else
        frame_score += rolls.take(2).sum
        rolls.shift(2)
      end
      running_score += frame_score
      frame_number += 1
    end

    running_score
  end

  private

  def is_spare_frame?(frame)
    frame.sum == 10
  end

  attr_reader :rolls
end
