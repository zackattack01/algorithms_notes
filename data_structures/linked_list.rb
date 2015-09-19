class Link
  attr_accessor :next, :prev
  attr_reader :val
  
  def initialize(val)
    @val = val
  end
end

class DoublyLinkedList
  attr_reader :head, :tail

  def initialize
    @head = Link.new(:head)
    @tail = Link.new(:tail)
    head.next = tail
    tail.prev = head
  end

  def empty?
    head.next == tail 
  end

  def each(&prc)
    current_node = head
    while current_node != tail
      current_node = current_node.next
      prc.call(current_node) unless current_node == tail
    end
    
    self
  end

  def delete(val)
    target = find(val)
    return nil unless target
    target.next.prev = target.prev
    target.prev.next = target.next

    target
  end

  def find(val)
    current_node = head
    while current_node != tail
      current_node = current_node.next
      return current_node if current_node.val == val
    end

    nil
  end

  def add_link(link)
    link.prev = tail.prev
    tail.prev.next = link
    tail.prev = link
    link.next = tail
  end

  def remove_last_link
    tail.prev = tail.prev.prev
    tail.prev.next = tail
  end
end