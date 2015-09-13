require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(size = 8)
    @count = 0
    @store = Array.new(size) { Array.new }
  end

  def insert(key)
    @count += 1
    @store[key.hash % @store.length].push key
    resize! if @count == @store.length
  end

  def include?(key)
    @store[key.hash % @store.length].include? key
  end

  def remove(key)
    @store[key.hash % @store.length].delete key
  end

  private

  def resize!
    next_store = Array.new(@store.length * 2) { Array.new }
    @store.each do |key|
      next_store[key.hash % next_store.length].push(key.hash)
    end
    @store = next_store
  end
end
