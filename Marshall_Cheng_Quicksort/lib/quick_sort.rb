require 'byebug'
class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]
    left = self.sort1(array.select{|el| el <= pivot})
    right = self.sort1(array.select{|el| el > pivot})

    left + [pivot] + right
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 1

    prc ||= Proc.new {|a,b| a <=> b}

    pivot_idx = self.partition(array, start, length, &prc)
    left_length = pivot_idx - start
    self.sort2!(array, start, left_length, &prc)
    self.sort2!(array, pivot_idx + 1, length - left_length - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new {|a,b| a <=> b}

    pivot = array[start]
    barrier_idx = start
    current_idx = start + 1
    while current_idx < start + length
      if prc.call(array[current_idx],pivot) == -1
        array[barrier_idx + 1], array[current_idx] = array[current_idx], array[barrier_idx + 1]
        barrier_idx += 1
      end 
      current_idx += 1
    end 
    array[barrier_idx], array[start] = array[start], array[barrier_idx]
    return barrier_idx
  end
end
