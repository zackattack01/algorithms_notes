# Asymptotic Analysis

## Big-Oh Notation

- For a function given n, as n grows it is bounded above a constant multiple of this function

- Way of talking about the bounds of an algorithm dropping leading constants and lower-order factors

- Some examples
  - Running through an array of length n one time: `O(n)`
  - Running through an array of length n two times: `O(n)`
  - Doubly nesting an array of length n (for each el run through the array again): `O(n²)`
  - Doubly nesting an array of length n (for each el run through the array from `current_idx + 1` on): still `O(n²)`
    - This gives us an average of `n/2` iterations per each index instead of `n`, but this is ignored

## Omega Notation

- Similar to Big-Oh notation, but says that function is bounded below by a constant multiple of this function

## Theta Notation

- Says that the function is equal to the given function
  - It will be in between two constant multiples of the function 

## Little-Oh Notation

- Stricter than Big-oh, the described function grows strictly slower than the given bound

- All possible constant multiples would need to be proven to leave the output of the function within this bound