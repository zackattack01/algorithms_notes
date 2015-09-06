require 'pry'
Link = Struct.new(:key, :val, :next, :prev)

class LinkedList
  include Enumerable

  attr_reader :head

  def initialize
    @head = Link.new
  end

  def insert(key, val)
    next_link = Link.new(key, val, nil, last)
    last.next = next_link
  end

  def last
    self.each { |link| return link unless link.next } || head
  end

  def get(key)
    link = get_link(key)
    link ? link.val : nil
  end

  def get_link(key)
    self.each do |link|
      return link if link.key == key
    end
    nil
  end

  def include?(key)
    !!get(key)
  end

  def remove(key)
    link = get_link(key)
    if link
      link.next.prev = link.prev
      link.prev.next = link.next
    end 
  end

  def each(&prc)
    link = head
    while link.next
      link = link.next  
      prc.call(link)
    end
  end
end

# list = LinkedList.new  
# list.insert(:first, 1)
# list.insert(:second, 2)
# list.insert(:third, 3)
# binding.pry