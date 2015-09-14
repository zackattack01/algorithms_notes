# Merge Sort

### Oldy but a goody
 
- Example of divide and conquer
  - where problem is broken down into smaller pieces and these are called recursively

- Better than selection sort
  - where repeated passes identify the min remaining el and swap that. O(n²)

- Better than insertion sort
  - where repeated passes identify where each el belongs in the sorted array that comes before it.  also O(n²) but can be good for small or already sorted lists

- Better than bubble sort
  - where repeated passes swap consecutive elements that are out of order relative to each other.  O(n²)

### Westside walk it out

```
    [5, 4, 1, 8, 7, 2, 6, 3]
          DIVIDES INTO

[5, 4, 1, 8] ←    → [7, 2, 6, 3]
     ↓                   ↓
[1, 4, 5, 8]  AND   [2, 3, 6, 7]
          
          MERGE INTO 
               ↓
    [1, 2, 3, 4, 5, 6, 7, 8]
```

### But how

- Split the array into 2 halves using a mid point

- 2 initial recursive calls, one for each half of the array

- base case will always be when the array is sorted (meaning it has ≤ 1 element)

### I meant how do you merge 

- Merge will take two arrays (left and right sides)

- While neither is empty, continue to shift the element from the array with the smallest first el (this will always be the smallest number in both arrays) into a `merged_result` array

- When one is empty, return `merged_result` concatenated to what's left of the arrays passed into the function

- This can also be done by keeping pointers to the current idx in both arrays and copying over the corresponding el into your result

### Time complexity

#### For merge

- O(n), number of els in the arrays

#### For the sort

- O(nlogn)

#### Prove it

- Starting at the root call we branch recursively until the base case (n = 1)

- The depth of this tree will be logn

- At any given level, there will be `2^depth_of_level` subproblems and each one will be of size `n/(2^depth_of_level)`

- So per level: multiply the number of subproblems times the work done per problem (merge which is O(n))

- At each level the size (n) is divided by `2^depth_of_level`, this will always cancel out the `2^depth_of_level` number of subproblems, so we're back to O(n) work per level

- n work per level times logn levels gives you O(nlogn)

### Thats a lot of words and my array still isn't sorted

```rb
class Array
  def self.merge(left_arr, right_arr)
    merged_result = []
    until left_arr.empty? || right_arr.empty?
      smallest_el = left_arr[0] < right_arr[0] ? left_arr.shift : right_arr.shift
      merged_result << smallest_el
    end

    merged_result + left_arr + right_arr
  end

  def merge_sort
    return self if length <= 1
    left, right = take(length / 2), drop(length / 2)
    Array.merge(left.merge_sort, right.merge_sort)
  end
end

print "Consider it " if [3, 5, 2, 1, 7, 3, 5, 4, 2, 1].merge_sort == [1, 1, 2, 2, 3, 3, 4, 5, 5, 7]
print "taken " if [-2, -4, 9, 1, 0, 3].merge_sort == [-4, -2, 0, 1, 3, 9]
print "care " if [1].merge_sort == [1]
puts  "of." if [].merge_sort == []
```
