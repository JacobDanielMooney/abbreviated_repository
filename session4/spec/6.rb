require 'rspec'

# In Ruby on Rails, when a person goes to a URL on your site, your application looks at the url, 
# and maps it to a controller method to handle the request
#
# My boss wanted to be able to specify what CSS class the body of the HTML output should have,
# based on which controller method was being accessed.
# It fell to me to provide a method, which, when invoked, would return a String that could handle the request
# 
# There are a few nuances, though.
# The String you return must be retained during the object's entire life
# The method must be able to be called multiple times
# The String you return should know how to add new classes: each class is separated by a space
# The only method you need to worry about being invoked is the << method.
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
#
#
# HINT: 
#   The concat method will do the same thing as the << method

class ApplicationController
  attr_accessor :body_string
  def other_method(&block)
    block_given?
  end
  def body_class
    class << @body_string
      def << (given_string)
        @body_string += " " unless @body_string.empty?
      end
    end
    @body_string
  end
  def initialize
    @body_string = String.new
  end
end


controller = ApplicationController.new
controller.other_method
controller.body_class
controller.body_class << 'admin'
controller.body_class
controller.body_class << 'category'
controller.body_class << 'page' << 'order'

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
  
end
