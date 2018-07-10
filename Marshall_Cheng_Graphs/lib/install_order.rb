require 'byebug'
# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to



def install_order(arr)
  pairs = {}
  queue = []
  sorted = [] 
  arr.each do |pair|
    pairs[pair[0]] = pair[1]
  end 
  packages = (1..pairs.keys.max).to_a
  packages.each do |package|
    if !pairs.keys.include?(package)
      queue.push(package)
    end 
  end 

  until queue.empty?
    package = queue.shift 
    sorted.push(package)
    neighbors = []

    pairs.each do |key, value|
      if value == package
        neighbors.push(key)
        pairs.delete(key)
      end 
    end
    neighbors.each do |package|
      if !pairs.keys.include?(package)
        queue.push(package)
      end 
    end 
  end  

  if packages.length == sorted.length 
    return sorted
  else 
    return []
  end 
end
