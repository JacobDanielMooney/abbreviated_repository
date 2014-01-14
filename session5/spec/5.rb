# There are many types of exceptions and errors in Ruby
# We want to get a list of them.
#
# We will assume that any constant whose name contains either
# "exception" or "error" anywhere in it, regardless of case,
# is either an exception or an error.
#
# The class Module contains a list of all globally available constants.
# Module's documentation is here http://ruby-doc.org/core/classes/Module.html
# Use the method (look through the documentation if you can't figure out which one it is)
# to get an array of all the constants, then use the Enumerable method called grep
# to extract from the Array the constants that are errors and exceptions
# grep documentation is at http://ruby-doc.org/core/classes/Enumerable.html#M003121
#
# The method grep is not defined on arrays. Yet I have just instructed you to use it. Why?
# (a question to make you think, it is not tested)
#
#
# Example:  list_of_errors_and_exceptions # => [ 'ArgumentError' , 'NoMethodError' , ... ]
# (depending on your Ruby version, your results will either be Strings of Symbols)

def list_of_errors_and_exceptions
  errors = Module.constants.grep(/error|exception/i)
end

errors = Module.constants.grep(/error|exception/i)

describe 'list_of_errors_and_exceptions' do
  
  # This sort of absurdness is to ensure we are explicitly looking
  # for the error, rather than replicating the same code in the
  # tests as the solution and having tests pass when they should fail.
  should_find = Proc.new do |error_to_find|
    Object.const_set error_to_find , Class.new(StandardError)
    errors << (errors.first.is_a?(Symbol) && error_to_find.to_sym || error_to_find.to_s) # this changes between 1.8 and 1.9, just make it work for both
    it "should find #{error_to_find}" do
      list_of_errors_and_exceptions.sort.should == errors.sort
    end
  end
  
  it 'should return an Array' do
    list_of_errors_and_exceptions.is_a?(Array).should be
  end
  
  it 'should return a list of all errors and exceptions' do
    list_of_errors_and_exceptions.sort.should == errors.sort
  end
  
  %w(
    Lowercaseerror 
    Lowercaseexception 
    Errorerr 
    Exceptionatstart 
    ExceptionAtStart 
    ExcEPtion 
    Abcexceptiondef
  ).each do |error_to_find|
    should_find.call error_to_find
  end
  
end

