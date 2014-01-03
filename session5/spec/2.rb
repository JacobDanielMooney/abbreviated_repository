require '1'

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  THIS IS A CONTINUATION OF CHALLENGE 1                                  #
#  YOU MUST HAVE CHALLENGE ONE PASSING BEFORE ATTEMPTING THIS CHALLENGE   #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# My boss can now add CSS classes from his controller, so he is happy.
# But there are a lot of controller methods, and so he has to go to a lot of different 
# places and type things like body_class << 'admin'
# 
# That is pretty redundant and not dry. It makes code confusing to read, so Rails has
# something called filters. My boss decided to use a before filter to set the CSS classes
# 
# In his controller, he told Rails:
# before_filter :set_admin , :except => [ :show , :index ]
#
# Then he created the method that he told the before filter to invoke
# def set_admin
#   body_class << 'admin'
# end
#
# Rails now knows that when an HTTP request is going to be handled by this controller,
# if the controller method handling the request is anything other than the methods named show and index,
# that it should first invoke the set_admin method. And in that method, he sets the CSS class.
# 
#
#
# The problem, is that there are several of these of these filters he wants to apply,
# and he wants to do it in _every_ controller. There are many controllers, and many classes
# and so this amounts to lots and lots of very redundant and simple code (we call this "boiler plate"). 
# So he called me over and said that he would like to be able to accomplish the same thing with just
# one line of code:
#
# css_classes 'admin' , :except => [ :show , :index ]
#
#
# I looked at the documentation, and the before_filter can take a block instead of a method name
# It will pass in the controller being operated on, so you could instead write the before filter like this:
#
# before_filter :except => [ :show , :index ] do |controller|
#   controller.body_class << css_class
# end
#
#
# YOUR TASK: Write the css_classes method.
#
#
# EXAMPLE INVOCATIONS:
# 
# class ProductsController < ApplicationController
#   css_classes 'product'   , :only => %w(show)
#   css_classes 'secondary' , 'admin_form' , :only => %w(new edit index) 
#   ...
#
# is the same as 
# class ProductsController < ApplicationController
#   
#   before_filter :only => %w(show) do |controller|
#     controller.body_class << 'product'
#   end
#   
#   before_filter :only => %w(new edit index) do |controller|
#     controller.body_class << 'secondary' << 'admin_form'
#   end
#   ...
#
# ---------------
#
# class CategoriesController < ApplicationController
#   css_classes 'no_header' , 'secondary' , :only => [ :sitemap , :search ]
#   ...
#
# is the same as
# class CategoriesController < ApplicationController
#   before_filter :only => [ :sitemap , :search ] do |controller|
#      controller.body_class << 'no_header' << 'secondary'
#   end
#   ...
#
#
# HINTS:
#   * Don't bother requiring the other file. To avoid relative require issues, the test will do it for you.
#   * First think about where you need to put this method so that it will be available to all the controllers
#   * You are going to need to combine variable length parameters with an options hash. This can't be done in the method signature

class ApplicationController
  class << self
    def before_filter(options=Hash.new,&block)
      before_filter_options options       # a method we stub to see that it gives what we expect
      before_filters << block if block
    end
    def before_filters
      @to_invoke ||= Array.new
    end
    def invoke_before_filters
      instance = self.new
      before_filters.each { |filter| filter.call instance }
      instance
    end
  end
end

describe 'css_classes' do

  before :each do
    @class = Class.new ApplicationController
  end

  it 'should be a class method of subclasses of ApplicationController' do
    @class.respond_to?(:css_classes).should be_true
  end

  it "should work for: 'product' , :only => %w(show)" do
    @class.class_eval do
      should_receive(:before_filter_options).with(:only => %w(show))
      css_classes 'product' , :only => %w(show)
      invoke_before_filters.body_class.should == 'product'
    end
  end
  
  it "should work for: 'product'" do
    @class.class_eval do
      should_receive(:before_filter_options).with({})
      css_classes 'product'
      invoke_before_filters.body_class.should == 'product'
    end
  end
  
  it "should work for: 'secondary' , 'admin_form' , :only => %w(new edit index)" do
    @class.class_eval do
      should_receive(:before_filter_options).with(:only => %w(new edit index))
      css_classes 'secondary' , 'admin_form' , :only => %w(new edit index) 
      invoke_before_filters.body_class.should == 'secondary admin_form'
    end
  end

  it "should work for 'admin' , 'administrator' , 'category' , 'business' , 'product' , :except => [ 'index' , 'create' ]" do
    @class.class_eval do
      should_receive(:before_filter_options).with(:except => [ 'index' , 'create' ])
      css_classes 'admin' , 'administrator' , 'category' , 'business' , 'product' , :except => [ 'index' , 'create' ]
      invoke_before_filters.body_class.should == 'admin administrator category business product'
    end
  end
end
