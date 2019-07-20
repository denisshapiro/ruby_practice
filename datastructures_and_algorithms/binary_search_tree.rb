Node = Struct.new(:value, :left, :right)

# Binary Seach Tree class
class BST
  attr_accessor :head

  def initialize(array)
    @array = array
    @tree = self.build_tree
  end

  def build_tree
    @head = Node.new

    @array.each do |num|
      if @head.value.nil?
        @head.value = num
      else
        insert(num, @head)
      end
    end
    @head
  end

  def insert(num, node)
    case
    when num < node.value && !node.left.nil? then insert(num, node.left)
    when num < node.value && node.left.nil? then node.left = Node.new(num)
    when num >= node.value && !node.right.nil? then insert(num, node.right)
    when num >= node.value && node.right.nil? then node.right = Node.new(num)
    end
  end

  def breadth_first_search(value)
    @queue = [@tree]
    @current = @tree

    until @current.value == value
      return nil if @queue.empty?

      @current = @queue.shift
      #p @current.value  
      @queue.push(@current.left) unless @current.left.nil?
      @queue.push(@current.right) unless @current.right.nil?
    end

    return "The node is #{@current}" if @current.value == value
  end

  def depth_first_search(value)
    @queue = [@tree]
    @current = @tree

    until @current.value == value
      return nil if @queue.empty?
      @current = @queue.pop
      #p @current.value
      @queue.push(@current.right) unless @current.right.nil?
      @queue.push(@current.left) unless @current.left.nil?
    end

    return "The node is #{@current}" if @current.value == value
  end

  def dfs_rec(value, root = @tree)
    return nil if root.nil?
    return "The node is #{root}" if root.value == value

    unless dfs_rec(value, root.left).nil?
      dfs_rec(value, root.left)
    else
      dfs_rec(value, root.right)
    end
  end
end

bst = BST.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

p bst.breadth_first_search(324)

p bst.dfs_rec(6345)

p bst.depth_first_search(324)

