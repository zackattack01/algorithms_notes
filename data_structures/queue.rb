class Queue
  def initialize(store = [])
    @store = store
  end

  def enqueue(el)
    @store << el
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end
end