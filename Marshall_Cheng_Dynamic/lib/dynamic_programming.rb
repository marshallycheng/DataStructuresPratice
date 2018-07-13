require 'byebug'
class DynamicProgramming

  def initialize
    # @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {1 => [[1]], 2=> [[1,1], [2]], 3 => [[1,1,1], [1,2], [2,1], [3]]}
    @maze_cache = {}
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
    return 0 if weights.length == 0 || capacity == 0
    solution_table = knapsack_table(weights, values, capacity)
    solution_table[capacity][-1]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    solution_table = []

    (0..capacity).each do |cap|
      solution_table[cap] = []
      (0...weights.length).each do |idx|
        if capacity == 0 
          solution_table[cap][idx] = 0
        elsif idx == 0 
          solution_table[cap][idx] = weights[idx] > cap ? 0 : values[idx]
        else
          option1 = solution_table[cap][idx - 1]
          option2 = weights[idx] > cap ? 0 : solution_table[cap - weights[idx]][idx - 1] + values[idx]
          optimum = [option1, option2].max
          solution_table[cap][idx] = optimum
        end  
      end 
    end 
    solution_table
  end

  def maze_solver(maze, start_pos, end_pos)
    build_cache(start_pos)
    solve_maze(maze, start_pos, end_pos)
    find_path(end_pos)
  end

  def solve_maze(maze, start_pos, end_pos)
    return true if start_pos == end_pos 

    get_moves(maze, start_pos).each do |new_spot|
      unless @maze_cache.keys.include?(new_spot)
        @maze_cache[new_spot] = start_pos
        solve_maze(maze, new_spot, end_pos)
      end 
    end 
  end 


  def find_path(end_pos)
    path = []
    current = end_pos
    until current.nil?
      path.unshift(current)
      current = @maze_cache[current]
    end 

    path
  end 
  def build_cache(start_pos)
    @maze_cache[start_pos] = nil
  end 

  def get_moves(moves, from_pos)
    directions = [[0,1],[1,0], [-1,0], [0,-1]]
    x, y = from_pos 
    result = []

    directions.each do |dx, dy|
      new_spot = [x + dx, y + dy]
      result << new_spot if is_valid_pos?(maze, new_spot)
    end 
    result
  end

  def is_valid_pos?(maze, pos)
    x, y = pos
    x >= 0 && y >= 0 && x < maze.length && y < maze.first.length && maze[x][y]
  end 
end
