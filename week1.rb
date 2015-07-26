require 'byebug'
##with iterative method break at midpoint of string
def string_reverse(str)
  return str if str.length == 1
  str[-1] + string_reverse(str[0..-2]) 
end

puts string_reverse("Hello")

## not the intended problem, this should initialize a 
## letter counts hash and find the first key with a val of 1
def first_non_repeating(str)
  return str[0] if str[0] != str[1]
  
  last_char = str[0]
  str[0..-1].each_char.with_index do |char, i|
    next if i == 0
    return char if char != last_char && char != str[i + 1]
    last_char = char  
  end
end

# puts first_non_repeating("xxxxxddeef")
## should use a hash of letter counts to avoid sorting
def anagram?(str1, str2)
  return false if str1.length != str2.length
  str1.split('').sort == str2.split('').sort
end

# p anagram?("bat", "tab") == true
# p anagram?("bat", "tabe") == false
# p anagram?("bat", "tdb") == false

## use a regex match here instead of each_cons
def rotation?(str1, str2)
  return false if str1.length != str2.length
  (str1*2).split('').each_cons(str1.length).to_a.each do |chunk|
    return true if chunk.join == str2
  end

  false
end

# puts rotation?("abcde", "deabc") == true
# puts rotation?("abcde", "deaac") == false
# puts rotation?("abcde", "deasac") == false