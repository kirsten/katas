class Game
  class BowlingError < StandardError; end

  def initialize(rolls = [])
    @rolls = rolls
  end

  def roll(pinfall)
    validate_pinfall(pinfall)

    rolls << pinfall

    @frames = create_frames(rolls)
  end

  def score
    score_frames
  end

  private

  MAX_PINS = 10

  attr_reader :rolls, :frames

  def validate_pinfall(pinfall)
    raise BowlingError unless pinfall.between?(0, MAX_PINS)
  end

  def score_frames
    frames.flatten.sum
  end

  def create_frames(rolls = [], frames = [], frame_number = 1)
    return frames if frame_number > 10

    create_frames(
      rolls.drop(num_rolls_in_frame(rolls)),
      frames << create_frame(rolls, frame_number),
      frame_number + 1
    )
  end

  def create_frame(rolls, frame_number)
    if frame_is_scorable?(rolls) && strike_frame?(rolls) && !strike_frame?(rolls.last(2)) && rolls.last(2).sum > MAX_PINS
      raise BowlingError
    end

    if !strike_frame?(rolls) && rolls.take(2).sum > MAX_PINS
      raise BowlingError
    end

    rolls.take(num_rolls_to_score_frame(rolls))
  end

  def num_rolls_in_frame(rolls)
    if strike_frame?(rolls)
      1
    elsif spare_frame?(rolls)
      2
    else
      2
    end
  end

  def num_rolls_to_score_frame(rolls)
    if strike_frame?(rolls)
      3
    elsif spare_frame?(rolls)
      3
    else
      2
    end
  end

  def frame_is_scorable?(rolls)
    rolls.length == num_rolls_to_score_frame(rolls)
  end

  def strike_frame?(rolls)
    rolls.take(1).sum == MAX_PINS
  end

  def spare_frame?(rolls)
    rolls.take(2).sum == MAX_PINS
  end
end
