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
      frame_score = rolls.sum
      score_frames(rolls.drop(rolls.length), frame_number, score + frame_score)
    elsif rolls.first == 10
      frame_score = rolls.take(3).sum
      score_frames(rolls.drop(1), frame_number + 1, score + frame_score)
    elsif rolls.take(2).sum == 10
      frame_score = rolls.take(3).sum
      score_frames(rolls.drop(2), frame_number + 1, score + frame_score)
    else
      frame_score = rolls.take(2).sum
      score_frames(rolls.drop(2), frame_number + 1, score + frame_score)
    end
  end

  attr_reader :rolls
end
