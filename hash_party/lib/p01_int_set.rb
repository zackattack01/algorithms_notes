class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if num > @store.length || num < 0
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end
end


class IntSet
  def initialize(length = 20)
    @store = Array.new(length) { Array.new }
  end

  def insert(num)
    @store[num % @store.length].push(num)
  end

  def remove(num)
    @store[num % @store.length].delete(num)
  end

  def include?(num)
    @store[num % @store.length].include? num
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(length = 20)
    @count = 0
    @store = Array.new(length) { Array.new }
  end

  def insert(num)
    @count += 1
    @store[num % @store.length].push(num)
    resize! if @count == @store.length
  end

  def remove(num)
    @count -= 1
    @store[num % @store.length].delete(num)
  end

  def include?(num)
    @store[num % @store.length].include? num
  end

  private

  def resize!
    next_store = Array.new(@store.length * 2) { Array.new }
    @store.flatten.each do |num|
      next_store[num % next_store.length].push(num)
    end
    @store = next_store
  end
end
