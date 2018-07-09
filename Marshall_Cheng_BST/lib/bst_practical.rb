require 'byebug'
require_relative 'binary_search_tree'
# def kth_largest(tree_node, k)
#   traverse_nodes(tree_node, k)
# end

# def traverse_nodes(root, k, arr = [])
#   traverse_nodes(root.right, k, arr) if root.right
#   arr.push(root)
#   traverse_nodes(root.left, k, arr) if root.left
#   return arr
# end 

def kth_largest(tree_node, k)
  right_size = tree_size(tree_node.right)
  if right_size == k - 1
    return tree_node 
  elsif right_size > k - 1
    return kth_largest(tree_node.right, k)
  else 
    return kth_largest(tree_node.left, k - 1 - right_size)
  end 
end 

def tree_size(node)
  return 0 unless node
  return 1 if node.left == 0 && node.right == 0
  tree_size(node.left) + tree_size(node.right) + 1
end 
