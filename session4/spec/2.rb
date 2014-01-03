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
