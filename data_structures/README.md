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