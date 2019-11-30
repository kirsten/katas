class Game
  class BowlingError < StandardError; end

  def initialize(rolls = [])
    @rolls = rolls
  end

  def roll(pinfall)
    validate_pinfall(pinfall)

    self.class.new(rolls << pinfall)
  end

  def score
    score_frames(rolls)
  end

  private

  attr_reader :rolls

  def validate_pinfall(pinfall)
    raise BowlingError unless pinfall.between?(0, 10)
  end

  def score_frames(rolls = [], frame_number = 1, score = 0)
    return score if rolls.empty?

    score_frames(
      rolls.drop(num_rolls_in_frame(rolls, frame_number)),
      frame_number + 1,
      score + rolls.take(num_rolls_to_score_frame(rolls, frame_number)).sum
    )
  end

  def num_rolls_in_frame(rolls, frame_number)
    if final_frame?(frame_number)
      3
    elsif rolls.take(1).sum == 10
      1
    else
      2
    end
  end

  def num_rolls_to_score_frame(rolls, frame_number)
    if final_frame?(frame_number)
      3
    elsif rolls.take(1).sum == 10
      3
    elsif rolls.take(2).sum == 10
      3
    else
      2
    end
  end

  def final_frame?(frame_number)
    frame_number == 10
  end
end
