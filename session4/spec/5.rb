require 'pathname'
require 'fileutils'
include FileUtils

# you will be given a file name
# inside the file will be a series of numbers
# find the largest number on each line
# return their sum
#
# EXAMPLE
#     file: nums.txt
#      406 217 799 116 45 651 808 780 
#      205 919 474 567 712 
#      776 170 681 86 822 9 100 540 812 
#      602 117 181 169 876 336 
#      434 165 725 187 974 48
#
# line_sums('nums.txt')   # =>   808 + 919 + 822 + 876 + 974   # =>   4399

def line_sums
end

def get_expected_answer(path)
  { 
    '8.1' => 4399                               ,
    '8.2' => 0                                  ,
    '8.3' => 4399                               ,
    '8.4' => 12                                 ,
    '8.5' => 3                                  ,
    '8.6' => 5                                  ,
    '8.7' => 23793343701                        ,
    '8.8' => 880754605216                       ,
    '8.9' => 2987648672                         ,
  }.fetch path[%r(\d+\.\d+$)] do |problem|
    raise "get_expected_answer generated #{problem} from #{path} but #{problem} was not in the expected answer list"
  end
end

resource_dir = Pathname.new(__FILE__).parent.parent + 'resources'

describe 'line_sums' do
  Dir[ (resource_dir + '*.template').to_s ].each do |template_path|
    
    real_path = template_path.sub /\.template$/ , ''
    
    cp template_path , real_path
    
    it "should return #{get_expected_answer real_path} for #{real_path}" do
      line_sums(real_path).should == get_expected_answer(real_path)
      rm real_path
    end
  
  end
end
