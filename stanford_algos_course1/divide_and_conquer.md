# Divide and Conquer

## Steps

- Steps One and Two are listed above, conquering is typically done recursively

- Solutions for each subproblem are collected and combined to answer the original problem

## Example problem: Counting Inversions

- Given an array of 1..n, provide the number of inversions
  - Inversions are pairs of indices (i, j) where array[i] > array[j].  (They're out of order)

- This type of problem could be used to generate a measure of similarity between ranked lists
  - Think of comparing customer's preferences to show what a user might like

- In an n element array the maximum number of inversions will be n choose 2

- Brute force is `O(n²)`

## Let's D&C it

- Each inversion can be either:
  - left: both indices are in the first half of the array
  - right: both indices are in the second half of the array
  - split: indices are in opposite halves of the array

- Use merge function from `merge_sort` to count inversions from split arrays

- When copying over from left and right arrays passed in, for each element in the right array that is copied over:
  - all of the remaining elements in the left array will be split inversions—keep track of these as `merged_result` is built
  - if there were no split inversions, all of left would be copied before right—we would return 0

- Base case is to return 0 inversions if array length ≤ 1

## So do it

```rb
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

puts sort_and_count([1, 2, 3, 5])[1] == 0
puts sort_and_count([1, 2, 5, 3])[1] == 1
puts sort_and_count([1, 3, 5, 2, 4, 6])[1] == 3
puts sort_and_count([7, 3, 5, 2, 4, 6, 1])[1] == 14
```