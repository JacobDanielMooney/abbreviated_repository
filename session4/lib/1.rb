# A stack is a collection of objects, where when you add a new object to the collection,
# called "pushing", it becomes the first object that you remove from the collection,
# called "popping". Arrays can be used as stacks:
stack = Array.new
stack.push 1
stack.push 2
stack
stack.pop
stack.pop
stack.pop



# But I want to implement it using linked lists instead of arrays.
class Node
  
  attr_accessor :next_node, :data
  
  def initialize(next_node, data)
    @next_node = next_node
    @data = data
  end
  
end


class Stack
  
  def initialize
    @head = nil
  end
  
  def push(data)
    @head = Node.new @head, data
  end
  
  def pop
    to_return = @head && @head.data
    @head &&= @head.next_node
    to_return
  end
  
end

stack = Stack.new
stack.push 1
stack.push 2
stack
stack.pop
stack.pop
stack.pop



# Looks good, except that inspection is uuuuuugly. It's the default 

# inspect method from Kernel, which knows nothing about our lists.

#

# I want you to override it so that I can do this:

stack = Stack.new

stack.push 1

stack.push 2

stack.push 3

stack



# stack.push 1

# stack.push 2

# stack.push 3

# stack # =>  (3)2)1)





class Stack

  def inspect

    node_inspector(@head,"")

  end

  def node_inspector(given_node, return_string)

    return "()" unless given_node

    if given_node.next_node

      return_string += given_node.data.inspect

      return_string += ")"

      node_inspector(given_node.next_node, return_string)

    else

      return_string = "(" + return_string + given_node.data.inspect + ")"

    end

  end

end



stack.inspect


