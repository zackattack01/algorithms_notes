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

