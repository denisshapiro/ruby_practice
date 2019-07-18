Node = Struct.new(:value, :next_node) do
  def to_ary
    [value, next_node]
  end
end

# Linked List class
class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = Node.new
    @tail = @head
  end

  def append(value)
    @current = @head
    @current = @head.next_node while @current != @tail

    if @current.value.nil? && @head == @tail
      @current.value = value
    elsif !@current.value.nil?
      @current.next_node = Node.new(value)
      @tail = @current.next_node
    end
  end

  def prepend(value)
    if @head == @tail && @head.value.nil?
      @head.value = value
    else
      @new = Node.new(value, @head)
      @head = @new
    end
  end

  def size
    @size = 0
    @current = @head
    return @size if @head == @tail && @head.value.nil?
    return @size + 1 if @head == @tail

    until @current == @tail
      @size += 1
      @current = @current.next_node
    end
    @size + 1
  end

  def at(index)
    @current_node = @head
    @current_index = 0

    until @current_index == index
      return nil if @current_node == @tail && @current_index < index

      @current_index += 1
      @current_node = @current_node.next_node
    end
    @current_node
  end

  def pop
    return if @head == @tail && @head.value.nil?
    return @head.value = nil if @head == @tail

    @current = @head
    @current = @current.next_node until @current.next_node.next_node.nil?
    @popped_node = @current.next_node
    @current.next_node = nil
    @tail = @current
    @popped_node
  end

  def contains?(value)
    @current = @head

    while @current.value != value
      return false if @current == @tail

      @current = @current.next_node
    end
    return true if @current.value == value
  end

  def find(data)
    @current_node = @head
    @current_index = 0

    while @current_node.value != data
      return nil if @current_node == @tail

      @current_node = @current_node.next_node
      @current_index += 1
    end
    @current_index
  end

  def to_s
    @current = @head
    return 'nil' if @head == @tail && @head.value.nil?

    @str = ''

    until @current.nil?
      @str += "( #{@current.value} ) -> "
      @current = @current.next_node
    end
    @str << 'nil'
  end

  def insert_at(index, value)
    @target = at(index)
    @new = Node.new(value, @target)

    if index.positive?
      @previous = at(index - 1)
      @previous.next_node = @new
      @tail = @new if index == size - 1
    else
      @head = @new
    end
  end

  def remove_at(index)
    @target = at(index)
    if index.positive?
      @previous = at(index - 1)
      @tail = @previous if index == size - 1
      @previous.next_node = @target.next_node
    else
      @head = @target.next_node
    end
    @target = nil
  end
end

linked_list = LinkedList.new
puts linked_list.to_s

linked_list.append(4)
puts linked_list.to_s
linked_list.append(10)
puts linked_list.to_s
linked_list.append(14)
puts linked_list.to_s

linked_list.prepend(100)
puts linked_list.to_s
linked_list.prepend(300)
puts linked_list.to_s

puts "size is #{linked_list.size}"

p linked_list.head
p linked_list.tail

p linked_list.at(3)

p linked_list.pop
puts linked_list.to_s

p linked_list.contains?(14)
p linked_list.contains?(10)

p linked_list.find(10)

puts linked_list.to_s

p linked_list.insert_at(3, 22)
puts linked_list.to_s

linked_list.insert_at(0, 50)
puts linked_list.to_s

linked_list.remove_at(2)
puts linked_list.to_s

linked_list.remove_at(4)
puts linked_list.to_s


linked_list.remove_at(0)
puts linked_list.to_s

linked_list.remove_at(2)
puts linked_list.to_s
