require 'byebug'
class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new 
    @prc ||= Proc.new{ |x, y| x <=> y}
  end

  def count
    @store.length
  end

  def extract
    raise "no element to extract" if count == 0 
    
    val = store[0]
    if count > 1
      @store[0] = @store.pop
      BinaryMinHeap.heapify_down(@store, 0, count)
    else 
      @store.pop 
    end 

    val

  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count - 1, count)
  end

  public
  def self.child_indices(len, parent_index)
    child_indices = []
    child1 = 2 * parent_index + 1
    child2 = 2 * parent_index + 2
    child_indices.push(child1) if child1 < len 
    child_indices.push(child2) if child2 < len
    child_indices
  end

  def self.parent_index(child_index)
    parent_index = (child_index - 1) / 2
    raise "root has no parent" if child_index == 0
    parent_index
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x,y| x <=> y}

    left, right = BinaryMinHeap.child_indices(len, parent_idx)
    parent_value = array[parent_idx]

    results = []
    results << array[left] if left
    results << array[right] if right

    if results.all? { |child| prc.call(parent_value, child) <= 0}
      return array 
    end
    
    swap = nil 
    if results.length == 1 
      swap = left 
    else 
      swap = prc.call(results[0], results[1]) == -1 ? left : right 
    end 

    array[parent_idx], array[swap] = array[swap], parent_value 
    heapify_down(array, swap, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    complete = false
    prc ||= Proc.new {|x, y| x <=> y}
    until complete || child_idx == 0
      complete = true 
      parent_idx = self.parent_index(child_idx)
      if prc.call(array[child_idx], array[parent_idx]) == -1
        array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
        complete = false 
        child_idx = parent_idx 
      end 
    end 
    array
  end
end 
