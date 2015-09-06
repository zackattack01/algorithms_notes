## Write your own version of binary XOR. Monkey-patch String class, 
## and XOR your string with another string. (Assume the other string is also in binary.)
class String
  def XOR(other_binary_string)
    self.split('').map.with_index do |c, idx|
      c = other_binary_string[idx] == c ? "0" : "1"
    end.join
  end
end

puts "1101".XOR("0101") == "1000"

## Write your own version of binary LSHIFT (<<), which takes in a Fixnum. Pad with 0s.

class String
  def LSHIFT(num)
    (self + ("0" * num))[num..-1]
  end
end

puts "1101".LSHIFT(2) == "0100"

## Determine whether a number is a power of 2 without using any looping constructs. 
## (Hint: think in terms of its binary representation and the bit operators you know.)

def power_of_two?(num)
  num.to_s(2).count("1") == 1
end

puts power_of_two?(2)
puts power_of_two?(4)
puts !power_of_two?(5)

def swap(x, y)
  x = x^y
  y = x^y
  x = x^y
  puts "#{x}, #{y}"
end

## WOAH a = [b, b=a][0]