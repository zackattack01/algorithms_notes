class Array
  def self.merge(left_arr, right_arr)
    merged_result = []
    @running_count ||= 0
    until left_arr.empty? || right_arr.empty?
      if left_arr[0] < right_arr[0]
        merged_result << left_arr.shift
      else
        merged_result << right_arr.shift
        @running_count += left_arr.length
      end
    end

    merged_result + left_arr + right_arr
  end

  def sort_and_count
    return self if length <= 1
    left, right = take(length / 2), drop(length / 2)
    Array.merge(left.sort_and_count, right.sort_and_count)
  end
end
 
# print "Consider it " if [3, 5, 2, 1, 7, 3, 5, 4, 2, 1].merge_sort == [1, 1, 2, 2, 3, 3, 4, 5, 5, 7]
# print "taken " if [-2, -4, 9, 1, 0, 3].merge_sort == [-4, -2, 0, 1, 3, 9]
# print "care " if [1].merge_sort == [1]
# puts  "of." if [].merge_sort == []
@running_count = 0
[1, 2, 3, 5].sort_and_count 
puts @running_count

@running_count = 0
[1, 2, 5, 3].sort_and_count 
puts @running_count