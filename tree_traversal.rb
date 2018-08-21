class Node
  attr_accessor :left, :right
  attr_reader :val
  def initialize(val)
    @val = val
    @left = nil 
    @right = nil
  end  

  def preorder(node)
    return unless node
    p node.val 
    preorder(node.left)
    preorder(node.right)
  end 

  def preorder_array(node)
    return [] unless node 
    results = []
    results.push(node.val)
    results.concat(preorder_array(node.left))
    results.concat(preorder_array(node.right))
    results
  end 

  def inorder(node)
    return unless node 
    inorder(node.left)
    p node.val
    inorder(node.right)
  end 

  def postorder(node)
    return unless node 
    postorder(node.left)
    postorder(node.right)
    p node.val 
  end 
end 