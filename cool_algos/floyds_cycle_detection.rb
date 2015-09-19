## Basic implementation for floyd's cycle-detection algorithm
## In a cyclic list the faster pointer will catch up to the slower pointer
def cyclic?(linked_list)
  tortoise = linked_list.head
  hare = linked_list.head

  ## if the list isn't cyclic the faster runner will eventually point to the tail or nil
  until hare == linked_list.tail || hare.nil?
    tortoise = tortoise.next
    hare = hare.next.next
    return true if tortoise == hare
  end

  false
end