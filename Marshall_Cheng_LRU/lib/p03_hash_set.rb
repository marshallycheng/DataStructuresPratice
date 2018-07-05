require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count == num_buckets
      resize!
    end

    self[key.hash].push(key) unless include?(key)
    @count += 1
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key.hash].delete(key)
      @count -= 1
    end 
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
