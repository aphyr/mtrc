class Mtrc::Sample
  # A simple key/value pair, where the keys are comparable.
  # Useful for storing associated information in a set of samples; for example,
  #
  # s = SortedSamples.new
  # s << Sample.new(1, "The first request")
  # s << Sample.new(2, "The second request")
  #
  # Which request cost the most?
  # (s % 100).value # => "The second request"

  include Comparable

  attr_accessor :key
  attr_accessor :value
  def initialize(key, value)
    @key = key
    @value = value
  end

  def <=>(o)
    self.key <=> o.key
  end
end
