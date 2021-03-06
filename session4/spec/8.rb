# Write a method that receives a number 1 through 5.
# Depending on the value of the number, it will raise
# some particular type of exception.
# 
# HINT:
#   All exceptions and errors are descendants of Exception.
#   (Exception is listed as an ancestor)
# 
# Examples:
#   exception_raiser 1   # =>   #<RuntimeError: No 1s allowed!>
#   exception_raiser 2   # =>   #<ArgumentError: No 2s allowed!>
#   exception_raiser 3   # =>   #<Exception: No 3s allowed!>
#   exception_raiser 4   # =>   #<SyntaxError: No 4s allowed!>
#   exception_raiser 5   # =>   #<RubyKickstartException: No 5s allowed!>

class RubyKickstartException < Exception
end

def exception_raiser(number_given)
  case number_given
  when 1
    raise "No 1s allowed!"
  when 2
    raise ArgumentError.new("No 2s allowed!")
  when 3
    raise Exception.new("No 3s allowed!")
  when 4
    raise SyntaxError.new("No 4s allowed!")
  when 5
    raise RubyKickstartException.new("No 5s allowed!")
  end
end


describe 'exception_raiser' do
  
  it 'should raise #<RuntimeError: No 1s allowed!> when given 1' do
    Proc.new { exception_raiser 1 }.should raise_error(RuntimeError, "No 1s allowed!")
  end
  
  it 'should raise #<ArgumentError: No 2s allowed!> when given 2' do
    Proc.new { exception_raiser 2 }.should raise_error(ArgumentError, "No 2s allowed!")
  end
  
  it 'should raise #<Exception: No 3s allowed!> when given 3' do
    Proc.new { exception_raiser 3 }.should raise_error(Exception, "No 3s allowed!")
  end
  
  it 'should raise #<SyntaxError: No 4s allowed!> when given 4' do
    Proc.new { exception_raiser 4 }.should raise_error(SyntaxError, "No 4s allowed!")
  end
  
  it 'should raise #<RubyKickstartException: No 5s allowed!> when given 5' do
    Proc.new { exception_raiser 5 }.should raise_error(RubyKickstartException, "No 5s allowed!")
  end
  
  [-1, 0, "abc", /abc/].each do |object|
    it "shouldn't raise an error when it receives #{object.inspect}" do
      Proc.new { exception_raiser object }.should_not raise_error
    end
  end
  
end

