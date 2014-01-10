# Write a method first_object, that takes three parameters
# and returns the first one that is true.
# 
# EXAMPLES:
# first_object 1, nil, nil    # => 1
# first_object nil, 1, nil    # => 1
# first_object nil, nil, 1    # => 1
# first_object nil, 1, 2      # => 1
# first_object nil, nil, nil  # => nil

def first_object(item1, item2, item3)
  results = item1 || item2
  results = item3 || nil unless results
  results
end

first_object(false, false, false)

describe 'first_object' do
  specify { first_object(1, nil, nil).should == 1 }
  specify { first_object(nil, 1, nil).should == 1 }
  specify { first_object(nil, nil, 1).should == 1 }
  specify { first_object(nil, 1, 2).should == 1 }
  specify { first_object(nil, nil, nil).should == nil }
  specify { first_object(false, false, false).should == nil }
  specify { first_object(false, false, true).should == true }
  specify { first_object(5, 4, 3).should == 5 }
  specify { first_object(5, nil, 3).should == 5 }
  specify { first_object(5, 4, nil).should == 5 }
end
