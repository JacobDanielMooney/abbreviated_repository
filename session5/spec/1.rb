# This is the same as 4:6 but now we want to make this more comprehensive
#
# There are a few nuances, though.
# The String you return must be retained during the object's entire life
# The method must be able to be called multiple times
# The String you return should know how to add new CSS classes: each class is separated by a space
# If someone tries to use + or []= or * on the String, you should raise a RuntimeError 
# with a message of "use << method instead"
# If they try to add the same String more than once, you should simply do nothing
#
# 0------------------------------
#
# EXAMPLE:
#   controller = ApplicationController.new
#   controller.body_class                 # => ""
#   controller.body_class << 'admin'
#   controller.body_class                 # => "admin"
#   controller.body_class << 'category'
#   controller.body_class                 # => "admin category"
#   controller.body_class << 'page' << 'order'
#   controller.body_class                 # => "admin category page order"
#   controller.body_class << 'category'
#   controller.body_class                 # => "admin category page order"
#   controller.body_class + 'landing'     # => #<RuntimeError: use << method instead>
#

module BCModule
  def <<(given_string)
    self.concat " " unless (length.zero?) || (self.split(" ").include? given_string)
    self.concat given_string unless self.split(" ").include? given_string
    self
  end
  def +(given_string)
    raise "use << method instead"
  end
  def []=(o,n)
    raise "use << method instead"
  end
  def *(given_string)
    raise "use << method instead"
  end
end

class ApplicationController
  def body_class
    unless @body_class
      @body_class = String.new
      @body_class.extend BCModule
    end
    @body_class
  end
end

controller = ApplicationController.new
controller.body_class
controller.body_class << "admin"
controller.body_class << "category"
controller.body_class << "page" << "order"



describe 'ApplicationController#body_class' do
  
  before :each do
    @ac = ApplicationController.new
  end
  
  it 'should return an empty string on first invocation' do
    ApplicationController.new.body_class.should == ""
  end
  
  it 'should become "admin" when receives << "admin"' do
    bc = ApplicationController.new.body_class
    bc << "admin"
    bc.should == "admin"
  end
  
  it 'should keep track of the variable it is using' do
    @ac.body_class << 'admin'
    @ac.body_class.should == 'admin'
  end
  
  it 'should not retain state across instances' do
    ac1 = ApplicationController.new
    ac1.body_class << "admin"
    ac2 = ApplicationController.new
    ac2.body_class << "page"
    ac1.body_class.should == "admin"
    ac2.body_class.should == "page"
  end

  it 'should place a space between CSS classes appended to it' do
    @ac.body_class << 'admin'
    @ac.body_class << 'category'
    @ac.body_class.should == 'admin category'
  end
  
  it 'should return the string when invoking << on the string' do
    (@ac.body_class << 'admin').object_id.should == @ac.body_class.object_id
  end
  
  it 'should be able to handle several CSS classes' do
    @ac.body_class << 'admin'
    @ac.body_class << 'category'
    @ac.body_class << 'page' << 'order'
    @ac.body_class.should == 'admin category page order'
  end

  
  it 'should not add the same class twice' do
    @ac.body_class << 'admin'
    @ac.body_class << 'admin'
    @ac.body_class.should == 'admin'
  end
  
  it 'should add both admin and administrator' do
    @ac.body_class << 'admin' << 'administrator'
    @ac.body_class.should == 'admin administrator'
  end
  
  it 'should add both administrator and admin' do
    @ac.body_class << 'administrator' << 'admin'
    @ac.body_class.should == 'administrator admin'
  end
  
  it 'should be chainable when finding repeats -- I should be able to say controller.body_class << "abc" << "abc" whether it matches or not' do
    @ac.body_class << 'admin' << 'category' << 'admin' << 'admin'
    @ac.body_class.should == 'admin category'
  end
  
  it 'should recognize repeat words in lists of words' do
    @ac.body_class << 'abc' << 'def' << 'ghi' << 'admin' << 'jkl' << 'admin' << 'mno' << 'administrator' << 'administrator' << 'abc' << 'b'
    @ac.body_class.should == 'abc def ghi admin jkl mno administrator b'
  end
  
  it 'should raise an argument exception for +' do
    @ac.body_class << 'admin'
    lambda { @ac.body_class + 'category' }.should raise_exception( RuntimeError  , 'use << method instead' )
  end
  
  it 'should raise an argument exception for *' do
    @ac.body_class << 'admin'
    lambda { @ac.body_class * 2 }.should raise_exception( RuntimeError  , 'use << method instead' )    
  end
  
  it 'should raise an argument exception for []=' do
    @ac.body_class << 'admin'
    lambda { @ac.body_class['mi'] = 'or' }.should raise_exception( RuntimeError  , 'use << method instead' )    
  end
  
end
