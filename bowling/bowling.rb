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

  MAX_PINS = 10

  attr_reader :rolls

  def validate_pinfall(pinfall)
    raise BowlingError unless pinfall.between?(0, MAX_PINS)
  end

  def score_frames(rolls = [])
    frames = create_frames(rolls)
    frames.flatten.sum
  end

  def create_frames(rolls = [], frames = [], frame_number = 1)
    return frames if rolls.empty?

    create_frames(
      rolls.drop(num_rolls_in_frame(rolls, frame_number)),
      frames << rolls.take(num_rolls_to_score_frame(rolls, frame_number)),
      frame_number + 1
    )
  end

  def num_rolls_in_frame(rolls, frame_number)
    if final_frame?(frame_number)
      3
    elsif rolls.take(1).sum == MAX_PINS
      1
    elsif rolls.take(2).sum == MAX_PINS
      2
    else
      2
    end
  end

  def num_rolls_to_score_frame(rolls, frame_number)
    if final_frame?(frame_number)
      3
    elsif rolls.take(1).sum == MAX_PINS
      3
    elsif rolls.take(2).sum == MAX_PINS
      3
    else
      2
    end
  end

  def final_frame?(frame_number)
    frame_number == 10
  end
end
