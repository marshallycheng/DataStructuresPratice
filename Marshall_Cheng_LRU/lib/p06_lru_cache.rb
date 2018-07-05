require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
     if @map[key]
      node = @map[key]
      update_node!(node)
      return node.val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    new_node = @store.append(key, val)
    @map[key] = new_node

    eject! if count > @max
    val
  end

  def update_node!(node)
    byebug
    node.remove

    @map[node.key] = @store.append(node.key, node.value)
  end

  def eject!
    removed_node = @store.first
    removed_node.remove
    @map.delete(removed_node.key)
  end
end
