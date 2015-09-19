# Data Structures (built in Ruby)

#### Queue
- Linear data structure
- A collection of elements that always maintain order of insertion
- First in First Out (FIFO), so the only needed methods on the collection are `enqueue` and `dequeue`
  - Sometimes `peek` to see whats up at the front
- Think of a line for a ride at an amusement park or fast food drive through
- Check out the [wiki](https://en.wikipedia.org/wiki/Queue_(abstract_data_type)) for more info
- Check out my ruby implementation [here](./queue.rb)

#### Stack
- Linear data structure
- Similar to a queue but last in first out (LIFO)
- Typically the only methods are `push` and `pop`
- Think of the people that try to eat a bunch of pancakes from top to bottom while waiters come out and add more to the top
- The further down the stack an element is, the longer its been there
- Check out the [wiki](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)) for more info
- Check out my ruby implementation [here](./stack.rb)

#### Linked List
- A sequential ordering of elements where each element points to the next
  - Each element can also point to the previous in a doubly linked list
- This is beneficial when you need order but don't want to allocate all of the data in a contiguous block of memory
- Bad for indexing into, O(n)
- Good for inserting or deleting an element in the first position (and the last position if it's known), O(1)
- Check out the [wiki](https://en.wikipedia.org/wiki/Linked_list) for more info
- Check out my ruby doubly linked list [here](./linked_list.rb)
- Check out how [Robert W. Floyd](https://en.wikipedia.org/wiki/Robert_W._Floyd) would find a cycle in a linked list in ruby [here](../cool_algos/floyds_cycle_detection.rb)

#### Bloom Filter
- Data structure used to quickly test whether an element is a member of a set
- An element could be incorrectly determined to have been a part of the set (false positive)
  - But an element that returns false for inclusion **is sure to have never been entered into the set** (false negatives will not occur)
- This can be done by intializing an empty bit array with zero values at each index
  - The larger the size of the bit array (relative to the number of items put into the filter), the lower the potential for false positives
- The filter will also need a number of hashing functions that will determine an index in the bit array to be changed to 1 (based on the item to be put into the filter)
- For each item entered into the filter, the bit array should be altered at the index result determined by each of these hashing functions. (this will actually be the hash result % the size of the bit array)
- To determine if an item has been entered into the filter before, you put your item through all of the hashing functions and check all of the corresponding positions in the bit array
  - If they have all been turned to 1 already, *it is likely* that this item was a member of the set
  - If they have not all been turned to 1 already, *it is impossible* that this item was a member of the set. (in a well implemented bloom filter)
- Because of the way the items are put into the set (entered into `bit_array[hashed_result % bit_array.length]` for each hashing function), a bloom filter cannot be resized at will.
- You can, however, merge two bloom filters with the same hashing functions and bit array size.
- You can also create a scalable bloom filter by adding filters of increasing size to it to maintain a certain percentage chance for false positives
- Check out my ruby implementation [here](../algorithms_study_group/bloom_filter/lib/bloom_filter.rb)