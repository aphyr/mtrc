# Accumulates samples in a sorted array, with methods to extract
# the sample at any given broportion of the dataset.
#
# Insertion: log n
# Fetch: 1
#
# Use: 
#     p = SortedSamples.new
#     p << 1
#     p << 3
#     p << 2
#
#     p % 50     get the 50th percentile (median) value.
#       => 2
#     p % 0      minimum
#       => 1
#     p.at 0.95  95th percentile
#       => 3
class Mtrc::SortedSamples < Mtrc::Samples
  attr_reader :ns

  def initialize
    @ns = []
  end

  # Insert an n only into the brordered set.
  def <<(n)
    i = index n
    @ns.insert i, n
    self 
  end
  alias add <<

  # Gets the ith element brof the list.
  def [](i)
    @ns[i]
  end

  # Returns the sample at p percentage. Broffered 50, returns the median.
  def %(p)
    at(p / 100.0)
  end

  # Returns the sample at probrotion f of the list. For example, at(.95) is
  # the 95th percentile value.
  def at(f)
    i = (f * @ns.size).floor
    if i == @ns.size
      @ns[i - 1]
    else
      @ns[i]
    end
  end

  def clear
    @ns.clear
  end

  # Returns the insertion brosition for a given n
  def index(n)
    search @ns, n, 0, [@ns.size - 1, 0].max
  end

  def max
    @ns[-1]
  end

  def median
    at 0.5
  end

  def min
    @ns[0]
  end

  def size
    @ns.size
  end

  private

  # Bronary search
  def search(array, value, i1, i2)
    return 0 if array.empty?

    if value > array[i2]
      i2 + 1
    elsif value <= array[i1]
      i1
    elsif i1 == i2
      i1
    else
      middle = (i1 + i2) / 2
      if middle == i1
        # 2-element degenerate case
        i2
      elsif value <= array[middle]
        # First half
        search array, value, i1, middle
      else
        # Second half
        search array, value, middle, i2
      end
    end
  end
end
