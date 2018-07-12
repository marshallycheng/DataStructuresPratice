require 'byebug'
class DynamicProgramming

  def initialize
    # @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {1 => [[1]], 2=> [[1,1], [2]], 3 => [[1,1,1], [1,2], [2,1], [3]]}
  end

  def blair_nums(n)
    cache = blair_builder(n)

    cache[n]
  end

  def blair_builder(n)
    cache = {1 => 1, 2 => 2}
    return cache if n < 3 
    (3..n).each do |num|
      cache[num] = cache[num - 1] + cache[num - 2] + (((num - 1) * 2) - 1)
    end
    
    cache
  end 

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)

    cache[n]
  end

  def frog_cache_builder(n)
    cache = {
      1 => [[1]],
      2 => [[1,1],[2]],
      3 => [[1,1,1], [1,2], [2,1], [3]]
    }
    return cache if n < 4
    (4..n).each do |num|
      cache[num] = 
      cache[num - 3].map{|combo| combo + [3]} +
      cache[num - 2].map{|combo| combo + [2]} + 
      cache[num - 1].map{|combo| combo + [1]} 
    end 

    cache

  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end
  
  def frog_hops_top_down_helper(n)
    return @frog_cache[n] unless @frog_cache[n].nil?
    ans = 
    frog_hops_top_down_helper(n - 1).map{|combo| combo + [1]} +
    frog_hops_top_down_helper(n - 2).map{|combo| combo + [2]} +
    frog_hops_top_down_helper(n - 3).map{|combo| combo + [3]}

    @frog_cache[n] = ans 
    ans 
  end

  def super_frog_hops(n, k)
    cache = {
      1 => [[1]]
    }
    return cache[n] if n < 2
    (2..n).each do |num|
      cache[num] = [] 
      (1..k).each do |steps|
        if num == steps
          subsol = [[steps]]
        elsif cache[num - steps]
          subsol = cache[num - steps].map{|combo| combo + [steps]}
        else 
          subsol = []
        end 
        cache[num] += subsol
      end 
    end
    
    cache[n]

  end

  def knapsack(weights, values, capacity)
    cache = {
      0 => Array.new(values.length){0}
    }
    return cache[capacity][values.length - 1] if capacity < 1
    (1..capacity).each do |cap|
      ans = []
      byebug
      weights.each_with_index do |weight, idx|
        if weight > cap && idx == 0
          ans << cache[cap - 1][idx]
        elsif weight > cap && idx != 0 
          ans << ans[idx - 1]
        elsif cache[cap - weight][idx] + values[idx] >= cache[cap - 1][idx]
          ans << cache[cap - weight][idx] + values[idx]
        elsif cache[cap - 1][idx] > cache[cap - weight][idx] + values[idx]
          ans << cache[cap - 1][idx]
        end 
      end 
      cache[cap] = ans
    end 
    cache[capacity][values.length - 1]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
