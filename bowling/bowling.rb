class Game
  def initialize(rolls = [])
    @rolls = rolls
  end

  def roll(pinfall)
    self.class.new(rolls << pinfall)
  end

  def score
    score_frames(rolls)
  end

  private

  def score_frames(rolls = [], frame_number = 1, score = 0)
    return score if rolls.empty?

    if frame_number == 10
      score_frames(rolls.drop(rolls.length), frame_number + 0, score + rolls.take(rolls.length).sum)
    elsif rolls.take(1).sum == 10
      score_frames(rolls.drop(1), frame_number + 1, score + rolls.take(3).sum)
    elsif rolls.take(2).sum == 10
      score_frames(rolls.drop(2), frame_number + 1, score + rolls.take(3).sum)
    else
      score_frames(rolls.drop(2), frame_number + 1, score + rolls.take(2).sum)
    end
  end

  attr_reader :rolls
end
