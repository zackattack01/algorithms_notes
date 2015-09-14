# require 'pry'
# class Array
#   def self.merge(left_arr, right_arr)
#     merged_result = []
#     @running_count ||= 0
#     until left_arr.empty? || right_arr.empty?
#       if left_arr[0] < right_arr[0]
#         merged_result << left_arr.shift
#       else
#         merged_result << right_arr.shift
#         # binding.pry
#         @running_count += left_arr.length
#       end
#     end

#     merged_result + left_arr + right_arr
#   end

#   def sort_and_count
#     return 0 if length <= 1
#     left, right = take(length / 2), drop(length / 2)
#     left_arr
#     merged_result = []
#     @running_count ||= 0
#     until left_arr.empty? || right_arr.empty?
#       if left_arr[0] < right_arr[0]
#         merged_result << left_arr.shift
#       else
#         merged_result << right_arr.shift
#         # binding.pry
#         @running_count += left_arr.length
#       end
#     end

#     merged_result + left_arr + right_arr
#     Array.merge(left.sort_and_count, right.sort_and_count)
#   end
# end

def sort_and_count(arr, running_total = 0)
  return [arr, 0] if arr.length <= 1
  left_return = sort_and_count(arr.take(arr.length / 2), running_total)
  left_arr = left_return[0]
  
  right_return = sort_and_count(arr.drop(arr.length / 2), running_total)
  right_arr = right_return[0]
  
  running_total = running_total + right_return[1] + left_return[1]
  
  merged_result = []
  until left_arr.empty? || right_arr.empty?
    if left_arr[0] < right_arr[0]
      merged_result << left_arr.shift
    else
      merged_result << right_arr.shift
      ### zero inversions would mean that every element in the left array would be shifted
      ### before every element in the right, so whenever a right element is shifted over any
      ### remaining elements in the left array are inversions
      running_total += left_arr.length
    end
  end

  [merged_result + left_arr + right_arr, running_total]
end
 
# print "Consider it " if [3, 5, 2, 1, 7, 3, 5, 4, 2, 1].merge_sort == [1, 1, 2, 2, 3, 3, 4, 5, 5, 7]
# print "taken " if [-2, -4, 9, 1, 0, 3].merge_sort == [-4, -2, 0, 1, 3, 9]
# print "care " if [1].merge_sort == [1]
# puts  "of." if [].merge_sort == []
puts sort_and_count([1, 2, 3, 5])[1] == 0
puts sort_and_count([1, 2, 5, 3])[1] == 1
puts sort_and_count([1, 3, 5, 2, 4, 6])[1] == 3
puts sort_and_count([7, 3, 5, 2, 4, 6, 1])[1] == 14
