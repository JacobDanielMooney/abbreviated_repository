$:.unshift File.dirname(__FILE__)

require '1'

# Require the stack code from challenge 1
# The code you added causes it to do this
# 
# stack = Stack.new
# stack.push 1
# stack.push 2
# stack # => (2)1)

# But sometimes you want it to inspect like an array.
# stack # => [1, 2]
# 
# Subclass the Stack class and override its inspect
# so that we can do this:
# 
# stack = StackInDisguise.new
# stack.push 1
# stack.push 2
# stack # => [1, 2]

class StackInDisguise < Stack
  def inspect
    node_inspector(@head, [])
  end

  def node_inspector(given_node, return_array)

    return return_array.to_s unless given_node

    if given_node.next_node

      return_array << given_node.data.inspect

      node_inspector(given_node.next_node, return_array)

    else

      return_array<<given_node.data.inspect

      return_array.to_s

    end

  end

end



stack_in_disguise = StackInDisguise.new

stack_in_disguise.push(1)

stack_in_disguise.inspect


