require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max) {false}
    @store.map {|el| false }
  end

  def insert(num)
    if num < 1 || num > @store.length
      raise "Out of bounds"
    end 
    @store[num - 1] = true 
    true
  end

  def remove(num)
    if num < 1 || num > @store.length
      raise "Out of bounds"
    end 
    @store[num - 1] = false
    true
  end

  def include?(num)
    return true if @store[num - 1] == true
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num].push(num) unless self[num].include?(num)
  end

  def remove(num)
    self[num].delete(num) if self[num].include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if (@count == num_buckets)
      resize!
    end

    self[num].push(num) unless include?(num)
    @count += 1
  end

  def remove(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2){Array.new}
    @store.each do |array|
      array.each do |num|
        bucket_num = num % (num_buckets * 2)
        new_store[bucket_num].push(num)
      end 
    end 

    @store = new_store
  end
end
