class Mtrc::Rate
  # A time differential. Accumulates ticks, and provides the rate in
  # ticks/second since t0.
  attr_accessor :t0
  attr_accessor :ticks
  def initialize
    @t0 = Time.now
    @ticks = 0
  end

  def rate
    @ticks / (Time.now - @t0)
  end

  def tick(delta = 1)
    @ticks += delta
  end
  alias << tick
end
