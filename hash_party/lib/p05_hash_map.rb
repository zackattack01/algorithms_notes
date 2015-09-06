require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count, :store

  def initialize(size = 8)
    @count = 0
    @store = Array.new(size) { LinkedList.new }
  end

  def include?(key)
    store[key.hash % store.length].include? key
  end

  def set(key, val)
    remove(key) if get(key)
    resize! if count > store.length
    store[key.hash % store.length].insert(key, val)
    @count += 1
  end

  def get(key)
    store[key.hash % store.length].get(key)
  end

  def delete(key)
    store[key.hash % store.length].remove(key)
    @count -= 1
  end

  def [](key)
    get(key)
  end

  def []=(key, val)
    set(key, val)
  end

  def each(&prc)
    store.each do |linked_list|
      linked_list.each do |link| 
        prc.call(link.key, link.val) 
      end
    end
  end

  private

  def resize!
    doubled_store = Array.new(store.length * 2) { LinkedList.new }
    store.each do |linked_list|
      linked_list.each do |list|
        doubled_store[list.key.hash % doubled_store.length].insert(link.key, link.val)
      end
    end
    @store = doubled_store
  end
end