# You are going to write a method called passthrough
# It receives an enumerable object, and an initial passthrough value, and a block
# 
# For each of the elements in the enumerable object,
# it passes them the passthrough value and the element.
# Whatever the block returns, must be passed in as the
# next passthrough value for the next element.
#
# After we go through all the elements, the last passthrough value is returned to the caller
#
#
# EXAMPLE:
#
# passthrough 5..10 , 0 do |sum,num|
#   sum + num
# end
# 
# This should return 45 in the following manner:
#   The first time the block is passed    0 ,  5 and it returns 5
#   The second time the block is passed   5 ,  6 and it returns 11
#   The third time the block is passed   11 ,  7 and it returns 18
#   The fourth time the block is passed  18 ,  8 and it returns 26
#   The fourth time the block is passed  26 ,  9 and it returns 35
#   The fourth time the block is passed  35 , 10 and it returns 45
#   The method then returns 45
#

def passthrough(given_range, pass_number, &block)
  given_range.each do |range_number|
    pass_number = block.call(pass_number , range_number)
  end
  pass_number
end


passthrough 5..10, 0 do |sum, num|
  sum + num
end


describe 'passthrough' do

  it 'should return what is passed in, if the enum is empty' do
    passthrough( Array.new , :passed_in ) { |a,b| :from_block }.should == :passed_in
  end
  
  it 'should return 45' do
    result = passthrough 5..10 , 0 do |sum,num|
      sum + num
    end
    result.should == 45
  end
  
  it 'should pass in the expected params' do
    expected_params = [ 
       0 ,  5 ,
       5 ,  6 ,
      11 ,  7 ,
      18 ,  8 ,
      26 ,  9 ,
      35 , 10 ,
    ]
    actual_params = Array.new
    result = passthrough 5..10 , 0 do |sum,num|
      actual_params << sum << num
      sum + num
    end
    actual_params.should == expected_params
  end

  it 'should return {5=>["hound"], 6=>["around"], 3=>["the", "fox", "and", "the", "ran", "all"]}' do
    result = passthrough %w(the fox and the hound ran all around) , Hash.new do |words,word|
      words[word.length] ||= Array.new
      words[word.length] << word
      words
    end
    
    result.should == { 5 => ["hound"] , 6 => ["around"] , 3 => ["the", "fox", "and", "the", "ran", "all"] }
  end

  it 'should return ["Will Jones", "Robert Jones", "John Smith", "Sally Smith"]' do
    married_couples = { 'Smith' => ['John' , 'Sally'] , 'Jones' => ['Will','Robert'] }

    people = passthrough married_couples , Array.new do |people,(last_name,first_names)|
      full_names = first_names.map { |first_name| "#{first_name} #{last_name}" }
      people + full_names
    end

     people.sort.should == ["Will Jones", "Robert Jones", "John Smith", "Sally Smith"].sort
  end
end
