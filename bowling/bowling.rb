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
      rolls.shift(rolls.length)
      score_frames(rolls, frame_number, score + frame_score)
    elsif rolls.first == 10
      frame_score = rolls.take(3).sum
      rolls.shift(1)
      score_frames(rolls, frame_number + 1, score + frame_score)
    elsif rolls.take(2).sum == 10
      frame_score = rolls.take(3).sum
      rolls.shift(2)
      score_frames(rolls, frame_number + 1, score + frame_score)
    else
      frame_score = rolls.take(2).sum
      rolls.shift(2)
      score_frames(rolls, frame_number + 1, score + frame_score)
    end
  end

  attr_reader :rolls
end
