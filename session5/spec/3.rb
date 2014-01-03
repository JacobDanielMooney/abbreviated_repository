# Write a list class. Implementation doesn't matter.
# 
# list = List.new
# list << 1
# list << 5
# list << 3
# list << 4
# list << 2
# list # => #<List: 1, 5, 3, 4, 2>
# 
# 
# Then give it an each method that iterates over its items in the order they were inserted
# ary = []
# ff.each do |crnt|
#   ary << crnt
# end
# ary # => [1, 5, 3, 4, 2]
# 
# 
# Then use the Enumerable module http://ruby-doc.org/core/classes/Enumerable.html to give
# your class its methods.
# ff.max                        # => 5
# ff.min                        # => 1
# ff.select { |num| num.odd? }  # => [1, 5, 3]

describe 'List' do
  
  specify 'List should exist' do
    Object.const_get('List').should be
  end
  
  it 'should be able to add items' do
    Proc.new { List.new << 1 }.should_not raise_error
  end
  
  it 'should have an each method that passes its elements' do
    list = List.new
    list << 1 
    list << 2
    results = []
    list.each { |element| results << element }
    results.should == [1, 2]
  end
    
  it 'should have an inspect method that knows about its state' do
    list = List.new
    list.inspect.should == '#<List: >'
    list << 1 
    list.inspect.should == '#<List: 1>'
    list << 5
    list << 3
    list << 4
    list << 2
    list.inspect.should == '#<List: 1, 5, 3, 4, 2>'
  end
  
  it 'should return itself so that it can be chained like list << 1 << "a"' do
    list = List.new
    (list << 1 << "a").should == list
  end

  describe 'List.new << 1 << 5 << 3 << 4 << 2' do
    subject { List.new << 1 << 5 << 3 << 4 << 2 }
    its(:max) { should == 5 }
    its(:min) { should == 1 }
    specify do
      subject.select { |num| num.odd? }.should == [1, 5, 3]
    end
    its(:count) { should == 5 }
    specify do
      subject.find { |num| num * 5 == 20 }.should == 4
      subject.find { |num| num * 5 == 21 }.should be_nil
    end
  end
  
  
end
