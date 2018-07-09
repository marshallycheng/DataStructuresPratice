require 'byebug'
require_relative 'bst_node'
# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_accessor :root
  def initialize
    @root = nil
  end

  def insert(value)
    new_node = BSTNode.new(value)
    if @root == nil
      @root = new_node 
    else 
      recursive_insert(@root, new_node)
    end 
  end

  def find(value, tree_node = @root)
    return tree_node if tree_node.value == value
    return nil if tree_node.left == nil && tree_node.right == nil
    if value < tree_node.value 
      return find(value, tree_node.left)
    elsif value > tree_node.value 
      return find(value, tree_node.right)
    end 
    nil
  end

  def delete(value)
    target = find(value, @root)
    if target == @root 
      @root = nil 
      return
    end 
    if target.left == nil && target.right == nil 
      target.parent.right = nil if target.parent.right == target
      target.parent.left = nil if target.parent.left == target
      target.parent = nil
    elsif target.left && target.right 
      max_left_node = maximum(target.left)
      if max_left_node.left 
        max_left_node.parent.right = max_left_node.left 
        max_left_node.left.parent = max_left_node.parent
      end 
      max_left_node.parent = target.parent 
      target.parent.right = max_left_node if target.parent.right == target
      target.parent.left = max_left_node if target.parent.left == target
      max_left_node.left = target.left 
      max_left_node.right = target.right
    elsif target.left || target.right 
      if target.left 
        target.parent.right = target.left if target.parent.right == target
        target.parent.left = target.left if target.parent.left == target
        target.left.parent = target.parent
      else 
        target.parent.right = target.right if target.parent.right == target
        target.parent.left = target.right if target.parent.left == target
        target.right.parent = target.parent
      end 
    end 
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right == nil 
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return 0 if tree_node == nil
    depth_left = depth(tree_node.left)
    depth_right = depth(tree_node.right)
    if tree_node.right == nil && tree_node.left == nil
      return 0 
    elsif depth_left > depth_right 
      return 1 + depth_left
    else
      return 1 + depth_right
    end 
  end 

  def is_balanced?(tree_node = @root)
    return true if tree_node == nil
    depth_left = tree_node.left ? depth(tree_node.left) : 0
    depth_right = tree_node.right ? depth(tree_node.right) : 0 
    if (depth_left - depth_right).between?(-1,1)
      if is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
        return true 
      end
    end 
    false  
  end

  def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr.push(tree_node.value)
    in_order_traversal(tree_node.right, arr) if tree_node.right
    return arr
  end


  private
  def recursive_insert(root, node)
    direction = root.value > node.value ? 'left' : 'right'
    if direction == 'left' 
      if root.left == nil 
        root.left = node 
        node.parent = root 
        return true 
      end 
      recursive_insert(root.left, node)
    elsif direction == 'right'
      if root.right == nil 
        root.right = node 
        node.parent = root 
        return true 
      end 
      recursive_insert(root.right, node)
    end 
    return false
  end 


end
