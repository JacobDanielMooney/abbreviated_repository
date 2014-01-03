# You are writing software for the Green Thumb Nursery. They sent you their inventory
# in a text document, but you need to extract the data in order to use it. You start to
# pull it out, by hand, one at a time. But it is tedious and your eyes start drooping.
#
# Suddenly, you realize "Hey, I know Ruby!", and decide to write a simple script to
# take care of this process for you.
# 
# The following string will be passed to your method to generate the list of trees with:
#   "American Redbud Tree, which ships at 1 to 2 feet, cost $5.95
#   Autumn Flowering Cherry, which ships at 2 to 4 feet, cost: $8.95
#   Black Walnut Tree; which ships at 1 to 2 feet, cost: $4.95
#   Cherokee Chief Dogwood, which ships at 2 to 4 feet, cost: $8.95
#   English Walnut Tree, Which ships at 1 to 2 feet, cost $10.95
#   Flowering Peach Tree, which ships at 2 to 4 feet, cost: $7.95
#   Flowering Pear Tree, which ships at 2 to 4 feet, cost: $8.50
#   Hydrangea Tree, which ships at 1 to 2 feet, cost: $5.95
#   Pecan Tree, which ships at 1 to 2 feet, cost: $5.95
#   Purple Leaf Plum Tree, which ships at 2 to 3 feet, cost: $5.95
#   Royal Empress Tree, which ships @ 2 to 4 feet, cost: $4.50
#   White Dogwood Tree, which ships at 2 to 3 feet, cost: $5.95"
# 
# **BE CAREFU!** The Green Thumb Nursery technician had a few fat fingers when entering
# the data, you'll have to make your regex robust enough to accommodate this.
# 
# Example:
#   given: "American Redbud Tree, which ships at 1 to 2 feet, cost $5.95")
#   you should return: [["American Redbud Tree", "1 to 2 feet", "$5.95"]]
# 
#   given: "American Redbud Tree, which ships at 1 to 2 feet, cost $5.95
#          Autumn Flowering Cherry, which ships at 2 to 4 feet, cost: $8.95"
#   you should return: [["American Redbud Tree", "1 to 2 feet", "$5.95"],
#                       ["Autumn Flowering Cherry", "2 to 4 feet", "$8.95"]]
# 

def tree_parser(trees)
end

describe 'tree_parser' do
  
  it 'should exist' do
    method(:tree_parser).should be
  end
  
  it "should give the correct html skeleton when no trees given" do
    tree_parser("") == []
  end

  trees = {
    "American Redbud Tree, which ships at 1 to 2 feet, cost $5.95"      => [ "American Redbud Tree"    , "1 to 2 feet" , "$5.95"  ],
    "Autumn Flowering Cherry, which ships at 2 to 4 feet, cost: $8.95"  => [ "Autumn Flowering Cherry" , "2 to 4 feet" , "$8.95"  ],
    "Black Walnut Tree; which ships at 1 to 2 feet, cost: $4.95"        => [ "Black Walnut Tree"       , "1 to 2 feet" , "$4.95"  ],
    "Cherokee Chief Dogwood, which ships at 2 to 4 feet, cost: $8.95"   => [ "Cherokee Chief Dogwood"  , "2 to 4 feet" , "$8.95"  ],
    "English Walnut Tree, Which ships at 1 to 2 feet, cost $10.95"      => [ "English Walnut Tree"     , "1 to 2 feet" , "$10.95" ],
    "Flowering Peach Tree, which ships at 2 to 4 feet, cost: $7.95"     => [ "Flowering Peach Tree"    , "2 to 4 feet" , "$7.95"  ],
    "Flowering Pear Tree, which ships at 2 to 4 feet, cost: $8.50"      => [ "Flowering Pear Tree"     , "2 to 4 feet" , "$8.50"  ],
    "Hydrangea Tree, which ships at 1 to 2 feet, cost: $5.95"           => [ "Hydrangea Tree"          , "1 to 2 feet" , "$5.95"  ],
    "Pecan Tree, which ships at 1 to 2 feet, cost: $5.95"               => [ "Pecan Tree"              , "1 to 2 feet" , "$5.95"  ],
    "Purple Leaf Plum Tree, which ships at 2 to 3 feet, cost: $5.95"    => [ "Purple Leaf Plum Tree"   , "2 to 3 feet" , "$5.95"  ],
    "Royal Empress Tree, which ships @ 2 to 4 feet, cost: $4.50"        => [ "Royal Empress Tree"      , "2 to 4 feet" , "$4.50"  ],
    "White Dogwood Tree, which ships at 2 to 3 feet, cost: $5.95"       => [ "White Dogwood Tree"      , "2 to 3 feet" , "$5.95"  ],
  }
    
  trees.each do |raw, expected|
    specify "Each line should match for #{raw.inspect}" do
      tree_parser(raw).should == [expected]
    end
  end
  
  trees.each_slice 2 do |a, b|
    raw = "#{a.first}\n#{b.first}"
    expected = [a.last, b.last]
    specify "Each line should match for #{raw.inspect}" do
      tree_parser(raw).should == expected
    end
  end
  
  it 'should match the entire block of text' do
    text      = trees.map(&:first).join("\n")
    expected  = trees.map(&:last)
    tree_parser(text).should == expected
  end
  
end

