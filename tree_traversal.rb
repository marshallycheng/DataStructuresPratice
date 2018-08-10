class Node
  attr_accessor :left, :right
  attr_reader :val
  def initialize(val)
    @val = val
    @left = nil 
    @right = nil
  end  
end 