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
    score = 0
    frames.each.with_index do |frame, index|
      if frame.length == 1 && frame.sum == 10
        score += frame.sum + frames.slice(index + 1, frames.length).flatten.take(2).sum
      elsif frame.length == 2 && frame.sum == 10
        score += frame.sum + frames.slice(index + 1, frames.length).flatten.take(1).sum
      else
        score += frame.sum
      end
    end
    score
  end

  def create_frames(rolls = [], frames = [], frame_number = 1)
    return frames if rolls.empty?

    if rolls.first != MAX_PINS && rolls.take(2).sum > MAX_PINS
      raise BowlingError
    end

    create_frames(
      rolls.drop(num_rolls_in_frame(rolls, frame_number)),
      frames << rolls.take(num_rolls_in_frame(rolls, frame_number)),
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
