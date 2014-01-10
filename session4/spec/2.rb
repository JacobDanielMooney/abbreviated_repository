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

class StackInDisguise < Stack
  def inspect
    node_inspector(@head, []).to_s
  end

  def node_inspector(given_node, return_array)
    return return_array.to_s unless given_node

    if given_node.next_node
      return_array.unshift(given_node.data)
      node_inspector(given_node.next_node, return_array)
    else
      return_array.unshift(given_node.data)
    end
  end
end

stack_in_disguise = StackInDisguise.new
stack_in_disguise.push(1)
stack_in_disguise.inspect


describe 'StackInDisguise' do

  specify 'it should be a subclass of Stack' do
    StackInDisguise.superclass.should == Stack
  end
  
  describe '#inspect' do
  
    before :each do
      @stack = StackInDisguise.new
    end
    
    it 'should be overridden' do
      @stack.method(:inspect).owner.should == StackInDisguise
    end
  
    it 'should be []' do
      @stack.inspect.should == "[]"
    end

    it 'should be [1]' do
      @stack.push 1
      @stack.inspect.should == '[1]'
    end

    it 'should be [{1=>2}]' do
      @stack.push({1=>2})
      @stack.inspect.should == '[{1=>2}]'
    end

    it 'should be [1, 2, 3]' do
      (1..3).each { |i| @stack.push i }
      @stack.inspect.should == '[1, 2, 3]'
    end
  
    it 'should be [1, 2, 3, 4, 5]' do
      (1..5).each { |i| @stack.push i }
      @stack.inspect.should == '[1, 2, 3, 4, 5]'
    end
  
    it 'should be [1, 2, 3, /abc/]' do
      (1..3).each { |i| @stack.push i }
      @stack.push(/abc/)
      @stack.inspect.should == '[1, 2, 3, /abc/]'
    end
  
    it 'should be [nil, false, true, "abc", [1, 2, 3]]' do
      [nil,false,true,"abc",[1,2,3]].each { |e| @stack.push e }
      @stack.inspect.should == '[nil, false, true, "abc", [1, 2, 3]]'
    end
  end
end

