class Stack
  def initialize(store = []) 
    @store = store
  end

  def push(el)
    @store << el
  end

  def pop
    @store.pop
  end
end