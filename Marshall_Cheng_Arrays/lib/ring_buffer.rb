require_relative "static_array"
require 'byebug'

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8 
    @length = 0
    @start_idx = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(@start_idx + index) % capacity] 
  end

  # O(1)
  def []=(index, val)
    @store[(@start_idx + index) % capacity] = val
  end

  # O(1)
  def pop
     if @length == 0
      raise "index out of bounds"
    end 

    @length -= 1
  end

  # O(1) ammortized
  def push(val)
    byebug
    if @length == @capacity 
      resize!
    end 
    @store[(@start_idx + @length) % @capacity] = val 
    @length += 1
  end

  # O(1)
  def shift
    if @start_idx == @capacity - 1
      @start_idx = 0
    else 
      @start_idx += 1
    end 
    @length -= 1
  end

  # O(1) ammortized
  def unshift(val)
    if @length == @capacity
      resize!
    end 

    if @start_idx == 0
      @start_idx = @capacity - 1
    else 
      @start_idx -= 1
    end 
    
    @store[@start_idx] = val
    
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    if index >= @length
      raise "index out of bounds"
    end
  end

  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)   

    @length.times do |idx|
      new_store[idx] = @store[idx]
    end 

    @store = new_store
  end
end
