Link = Struct.new(:key, :val, :next, :prev)

class LinkedList
  attr_reader :head

  def initialize
    @head = Link.new
  end

  def insert(key, val)
    
    Link.new(key, val, nil, )
  end

  def get(key)
    link = @head
    until link.key = key
      link = link.next
    end
    link.val
  end

  def include?(key)
  end

  def remove(key)
  end

  def each
  end
end
