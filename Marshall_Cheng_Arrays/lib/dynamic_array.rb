require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(@length)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    # check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    if @length == 0
      raise "index out of bounds"
    end 
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == @capacity 
      resize!
    end 
    @store[@length] = val 
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    if @length == 0 
      raise "index out of bounds"
    end 

    (@length - 1).times do |idx|
      @store[idx] = @store[idx + 1]
    end 
    @store[@length - 1] = nil
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    (@length).downto(1) do |idx|
      @store[idx] = @store[idx - 1]
    end 
    @store[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    if index >= @length
      raise "index out of bounds"
    end
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)   

    @length.times do |idx|
      new_store[idx] = @store[idx]
    end 
    
    @store = new_store
  end
end
