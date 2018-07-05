require 'byebug'
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next 
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new('head')
    @tail = Node.new('tail')
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    return true if @head.next == @tail 
    false
  end

  def get(key)
    current_node = @head.next
    until current_node == @tail 
      return current_node.val if current_node.key == key 
      current_node = current_node.next
    end
    nil 
  end

  def include?(key)
    current_node = @head.next 
    until current_node == @tail 
      return true if current_node.key == key
      current_node = current_node.next 
    end 
    false
  end

  def append(key, val)
    node = Node.new(key, val)
    last.next = node 
    node.prev = last 
    @tail.prev = node
    node.next = @tail
  end

  def update(key, val)
    current_node = @head.next
    until current_node == @tail 
      current_node.val = val if current_node.key == key 
      current_node = current_node.next
    end
  end

  def remove(key)
    current_node = @head.next
    until current_node == @tail 
      if current_node.key == key 
        current_node.remove 
        break
      end 
      current_node = current_node.next
    end
  end

  def each
     current_node = @head.next
    until current_node == @tail
      yield current_node
      current_node = current_node.next
    end
  end

#   # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
