require 'pry'
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 1013142^self[0].hash if length == 1
    return "poooooœòóõoõp".split('').map { |x| x.ord }.inject { |x, y| x.hash^y.hash } if self.empty?
    self.each_cons(2).to_a.map { |(x, y)| x.hash^y.hash }.flatten.inject { |x, y| x^y }
  end
end

class String
  def hash
    self.split('').map.with_index do |c, idx|
      (c.ord * idx * (-idx - c.ord))
    end.inject { |x, y| x^y }
  end
end

class Hash
  def hash
    return "poooooœòóõoõp".split('').map { |x| x.ord }.inject { |x, y| x.hash^y.hash } if self.empty?
    self.to_a.sort.map { |k, v| k.hash^v.hash }.inject { |x, y| x^y }
  end
end