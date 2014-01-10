require 'date'
require 'pathname'

# Given an object, return the name of its longest method
# o = Object.new
# def o.this_is_a_really_really_really_really_really_long_method_name
# end
# 
# longest_method o # => :this_is_a_really_really_really_really_really_long_method_name

def longest_method(given_object)
    @longest_symbol = :a
    array_of_methods = given_object.methods
    array_of_methods.each do |element|
        @longest_symbol = element if element.length > @longest_symbol.length
    end
    @longest_symbol
end

o = Object.new
def o.this_is_a_really_really_really_really_really_long_method_name
end

longest_method o

describe 'longest_method' do
  [ 1,
    2,
    2**1000,
    "abc",
    /abc/,
    Object.new,
    Object,
    Class,
    Class.new,
    Date.today,
    Pathname.new('.'),
    Time.now,
    Object.new.instance_eval { def this_is_a_really_really_really_really_really_long_method_name; end; self },
  ].each do |object|
    # This might be cheating, but I'm hesitant to hard code something in here,
    # given that it could change as Ruby changes.
    expected = object.methods.max_by(&:length)
    it "should return #{expected.inspect} for #{object.inspect}" do
      longest_method(object).should == expected
    end
  end
end
