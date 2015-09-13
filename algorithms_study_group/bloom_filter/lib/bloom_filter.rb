require 'murmurhash3'
require 'pry'

class BloomFilter
  attr_reader :failure_rate, :capacity, :num_bits, :bit_array, :count,
              :bits_flipped, :hash_num, :random_variations

  def self.required_bits(capacity, failure_rate)
    (-(capacity * Math.log(failure_rate)).fdiv(Math.log(2) ** 2)).round
  end

  def self.required_hashes(capacity, num_bits)
    (Math.log(2) * (num_bits.fdiv(capacity))).ceil
  end

  def initialize(capacity, failure_rate = 0.001)
    # the asymptotic rate of false positives
    @failure_rate = failure_rate
    # the max number of items in the filter (for which we'll guarantee the failure rate):
    @capacity = capacity
    # the required number of bits in the array:
    @num_bits = BloomFilter.required_bits(capacity, failure_rate)
    # our bit array uses true/false instead of 0/1:
    generate_new_filter

    @capacity.times { |i| @bit_array[i] = false }
    # the number of unique additions to the filter:
    @count = 0
    # the number of bits that have been flipped in our filter:
    @bits_flipped = 0
    # the number of hash functions that minimizes the probability of false positives:
    @hash_num = BloomFilter.required_hashes(capacity, @num_bits)
    # random bytes that we'll use to generate new composite hashes:
    @random_variations = [] 
    generate_hash_variations
  end

  def generate_new_filter
    @bit_array = Array.new(@num_bits, false)
  end

  def insert(key)
    added = false
    hashed = hash(key.hash)
    @random_variations.each do |var|
      idx = hash(hashed^var) % @num_bits
      unless @bit_array[idx]
        added = true
        @bit_array[idx] = true
        @bits_flipped += 1
      end
    end

    @count += 1 if added
    count
  end

  def include?(key)
    hashed = hash(key.hash)
    @random_variations.all? { |var| @bit_array[(hash(hashed^var) % @num_bits)] }
  end

  def clear
    generate_new_filter
  end

  def inspect
    "Count: #{@count}\n
    Number of bits: #{@num_bits}\n
    Bits flipped: #{@bits_flipped}\n
    Number of hashes: #{@hash_num}"
  end

  def merge!(other_filter)
    unless other_filter.is_a?(BloomFilter) && 
        other_filter.num_bits == num_bits  &&
        other_filter.hash_num == hash_num
      raise ArgumentError 
    end
    bit_array.each_with_index do |bit_val, idx|
      next if bit_val
      bit_array[idx] = true if other_filter.bit_array[idx]
    end
  end

  private

  def hash(num)
    MurmurHash3::V32.int64_hash(num)
  end

  def generate_hash_variations
    @hash_num.times do |i|
      @random_variations << hash([*i..i + 5].join('').to_i)
    end
  end

  class Scalable
    SIZE_SCALE_FACTOR = 2
    FAILURE_SCALE_FACTOR = Math.log(2) ** 2
    attr_reader :bloom_filters, :failure_rate

    def initialize(initial_capacity, failure_rate = 0.001)
      @failure_rate = failure_rate
      # Here are all your Bloom Filters. Remember that they asymptotically
      # approach your failure rate by multiplying their failure rates
      # by the failure scale factor, raised to increasing powers for every subsequent
      # Bloom Filter. Remember to do this for your first Bloom Filter too.
      @bloom_filters = [BloomFilter.new(initial_capacity, failure_rate * FAILURE_SCALE_FACTOR)]
    end

    def count
      bloom_filters.map { |bf| bf.count }.inject(:+)
    end

    def insert(key)
      insertion_count = current_filter.insert(key)
      add_filter! if insertion_count > current_filter.capacity
    end

    def include?(key)
      bloom_filters.each { |bf| return true if bf.include? key }
      false
    end

    def merge!(other_filter)
      raise ArgumentError unless other_filter.is_a?(BloomFilter::Scalable)
      @bloom_filters = other_filter.bloom_filters + bloom_filters
    end

    private

    def current_filter
      bloom_filters.last
    end

    def add_filter!
      # The new filter's capacity should be scaled by the size scale factor.
      cap = current_filter.capacity * SIZE_SCALE_FACTOR
      # Its failure rate should be scaled by the failure scale factor raised to
      # (your number of filters) + 1.
      fr = failure_rate * (FAILURE_SCALE_FACTOR ** (bloom_filters.length + 1))

      bloom_filters << BloomFilter.new(cap, fr)
    end
  end

  # For your testing pleasure. Can also be used to test Scalable Filters by
  # passing `BloomFilter::Scalable` as your third argument.
  def self.test_false_positive_rate(test_size, print_to_screen = true, type = BloomFilter)
    bf = type.new(test_size)
    (0...test_size).each { |n| bf.insert(n) }
    false_positives = (test_size...test_size * 2).inject(0) do |count, n|
      count += 1 if bf.include?(n)
      count
    end
    rate = false_positives.fdiv(test_size)

    if print_to_screen
      puts "Your Bloom Filter had a false positive rate of #{rate * 100}%.\n"\
           "Its actual rate should have been #{bf.failure_rate * 100}%."
    end
    rate
  end
end

# bf = BloomFilter.new(10_000, 0.001)
# sbf = BloomFilter::Scalable.new(2, 0.001)
# binding.pry