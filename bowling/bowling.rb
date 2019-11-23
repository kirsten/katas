class Game
  def initialize(rolls = [])
    @rolls = rolls
  end

  def roll(pinfall)
    self.class.new(rolls << pinfall)
  end

  def score
    running_score = 0
    frames = rolls.each_slice(2).to_a
    frames.each.with_index do |frame, index|
      if is_spare_frame?(frame)
        running_score += frame.sum + frames[index + 1][0]
      else
        running_score += frame.sum
      end
    end
    running_score
  end

  private

  def is_spare_frame?(frame)
    frame.sum == 10
  end

  attr_reader :rolls
end
