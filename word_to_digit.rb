Write a method that takes a sentence string as input, 
and returns the same string with any sequence of the words 
'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine' converted to a string of digits.

Example:
word_to_digit('Please call me at five five five one two three four. Thanks.') == 'Please call me at 5 5 5 1 2 3 4. Thanks.'

#=begin PEDAC
string in, new string out
define method 1 param (string)
make a constant string of number words 0..9, 
index will correspond to word
split string into array
check each word, against constants,
replace word with index
rejoin string
GOTTA MUTATE THE STRING

NUMBERS = %w(zero one two three four five six seven eight nine ten)

def word_to_digit(string)
  array = string.split
  array.map! do |word|
    word = NUMBERS.index(word) if NUMBERS.include?(word)
  end
  array.join(' ')
end

irb(main):212:0> word_to_digit('Please call me at five five five one two three four. Thanks.') == 'Please call me at 5 5 5 1 2 3 4.
 Thanks.'
=> false
irb(main):213:0> word_to_digit('Please call me at five five five one two three four. Thanks.')
=> "    5 5 5 1 2 3  "

LOST ALL NON WORDS, AND NO PUNCTUATED 4.
THIS FIXES THE LOST WORDS BUT NOT THE FOUR.

def word_to_digit(string)
  array = string.split
  array.map! do |word|
    NUMBERS.include?(word) ? (word = NUMBERS.index(word)) : word
  end
  array.join(' ')
end
###########
NUMBERS.each_with_index do |word, index|
  string.gsub!(word, index.to_s)
end
# THIS WORKS MODIFIES THE STRING BUT RETURNS THE NUMBERS ARRAY
# SO CALL string AT THE END OF THE METHOD

def word_to_digit(string)
  NUMBERS.each_with_index do |word, index|
    string.gsub!(word, index.to_s)
  end
  string
end
# WORKS PERFECTLY!
#=begin THEIR CODE

DIGIT_HASH = {
  'zero' => '0', 'one' => '1', 'two' => '2', 'three' => '3', 'four' => '4',
  'five' => '5', 'six' => '6', 'seven' => '7', 'eight' => '8', 'nine' => '9'
}.freeze

def word_to_digit(words)
  DIGIT_HASH.keys.each do |word|
    words.gsub!(/\b#{word}\b/, DIGIT_HASH[word])
  end
  words
end
#=end THEIR CODE
#=Begin FE
Can you change your solution so that the spaces between consecutive numbers are removed? 
Suppose the string already contains two or more space separated numbers (not words); 
can you leave those spaces alone, while removing any spaces between numbers that you create?

What about dealing with phone numbers? Is there any easy way to format the result to 
account for phone numbers? For our purposes, assume that any 10 digit number is a phone number, 
and that the proper format should be "(123) 456-7890".

split according to spaces
Maybe a punctuation check? -helper method
need regular array to store words that need to stay the same before numbers
need numbers array to store words to change and format -helper method
need another regular array to store words after numbers

def word_to_digit(string)
  NUMBERS.each_with_index do |word, index|
    string.gsub!(/\b#{word}\b/, index.to_s)
  end
  string
end



if 10 digits /(\s\d){7,10}/
slice everything before this into 1 variable A
slice that into 1 variable B
slice end into 1 variable C

interpolate A + " (#{B[0,3]}) #{B[3,3]}-#{B[6,4]}" + C

#=begin CALEB PICKARDS CODE
NUMS = { 'zero' => '0', 'one' => '1', 'two' => '2', 'three' => '3',
         'four' => '4', 'five' => '5', 'six' => '6', 'seven' => '7',
         'eight' => '8', 'nine' => '9', 'ten' => '10'} # I ADDED THE ten/10

def word_to_digit(str)
  NUMS.keys.each { |num| str.gsub!(/(\b|(?<=[0-9]))#{num}\b ?/i, NUMS[num]) }
  str.gsub!(/([0-9])([a-zA-Z])/, '\1 \2')  # adds back space deleted in prev step
  str.gsub!(/(\d{3})(\d{3})(\d{4})/, '(\1) \2-\3')   # formats phone numbers
  str
end
irb(main):273:0> word_to_digit("eight freights hone one's sixtieth ten")
=> "8 freights hone 1's sixtieth 10"
irb(main):274:0> word_to_digit("eight freights hone one's sixtieth tensioned ten")
=> "8 freights hone 1's sixtieth tensioned 10"
irb(main):275:0> word_to_digit("eight freights hone one's sixtieth tensioned ten five five six.")
=> "8 freights hone 1's sixtieth tensioned 10556."
irb(main):276:0> word_to_digit("eight freights hone one's sixtieth tensioned ten five five six ten ten ten ten.")
=> "8 freights hone 1's sixtieth tensioned (105) 561-0101010."
irb(main):277:0> word_to_digit('ten ten ten ten ten ten ten ten ten ten')
=> "(101) 010-1010(101) 010-1010"
irb(main):278:0> word_to_digit('ten ten ten ten ten ten ten ten ten tenten')
=> "(101) 010-101010101010 tenten"

