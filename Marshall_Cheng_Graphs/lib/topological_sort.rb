require 'byebug'
require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  queue = []
  sorted = []
  vertices.each do |vertex|
    if vertex.in_edges.empty?
      queue.push(vertex)
    end 
  end 

  until queue.empty?
    vertex = queue.shift
    sorted.push(vertex)
    neighbors = [] 

    vertex.out_edges.length.times do |i|
      edge = vertex.out_edges[0]
      neighbors.push(edge.to_vertex)
      edge.destroy!
      # should be enough to remove edge, dont need to explicitly remove vertex
    end 
    neighbors.each do |vertex|
      if vertex.in_edges.empty?
        queue.push(vertex)
      end 
    end 
  end 

  if vertices.length == sorted.length 
    return sorted 
  else 
    return []
  end 
end

# def topological_sort(vertices)
#   visited = {}
#   sorted = []
#   vertices.each do |vertex|
#     visit(vertex, sorted, visited)
#     visited[vertex] = true
#     sorted.unshift(vertex)
#   end 
#   sorted
# end 

# def visit(vertex, sorted, visited)
#   if visited[vertex] || vertex.out_edges.empty?
#     sorted.unshift(vertex)
#   else
#     vertex.out_edges.each do |edge|
#       visit(edge.to_vertex, sorted, visited)

#     end 
#   end 
# end 