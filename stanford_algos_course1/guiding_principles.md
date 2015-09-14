# Guiding Principles

### Guiding Principle I: Worst-case analysis

- What's generally important is worst-case analysis, this is the bound that will hold for every input of length n

- There's also average-case, who's name is fitting enough to not write anything else

- Also bench marks for given n, but typically worst-case is the easiest to analyze and most important

### Guiding Principle II: Ignore constants and lower order factors

- Constant factors and lower order terms are generally ignored
  - There will be big enough difference between languages, compilers, optimizations, etc that these can be tough to account for accurately
  - These can also cause us lose focus of what can make our algorithms more scalable

### Guiding Principle III: Asymptotic Analysis

- Focus on running time for large n, with small enough n this won't matter much

- As n increases `O(n²)` dwarfs `nlogn`, but with small n you'll want the algorithm with smaller constant factors
  - You'd want insertion sort before merge sort for small enough n 

- Something is considered a fast algorithm when it's worst case running time grows slowly with input size