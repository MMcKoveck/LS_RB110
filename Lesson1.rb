# PROBLEM:

# Given a string, write a method `palindrome_substrings` which returns
# all the substrings from a given string which are palindromes. Consider
# palindrome words case sensitive.

# Test cases:

# palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
# palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
# palindrome_substrings("palindrome") == []
# palindrome_substrings("") == []
=begin
# INPUT, OUTPUT, and RULES
Input  : String Argument
Output : Array of all sub strings that are palindromes
Rules  : Palindromes are case sensitive, they consist of 2 or more characters that are == forward & back
         No palindromes (empty or not) return empty Array
         Any palindrome longer than 3 will have sub palindromes

#=end
def substrings(str)
  result = []
  starting_index = 0
  num_chars = 2
  while starting_index <= str.length - 2
    puts str.slice(starting_index, num_chars)
    starting_index += 1
  end
end

substrings("abc")

# Expected output:
# "ab"
# "bc"

need main array = []
need sub arrays
need keeper value = 0
need a final length = main_arg
need a current length = 1
loop 
  make sub array
    loop
      add 2 to keeper value and push to sub Array
      when sub array is current length long, push sub array to main array 
    end inner loop
  increment current length + 1
  reset sub array
break when main array has final length elements (sub arrays)
end
return main array[-1]sum
=end

def sum_even_number_row(main_arg)
  main_array = []
  keeper_value = 0
  current_length = 1
  loop do
    sub_array = []
    loop do
      keeper_value += 2
      sub_array << keeper_value
      break if sub_array.size == current_length
    end
    main_array << sub_array
    current_length += 1
    break if main_array.size == main_arg
  end
  main_array[-1]#.sum
end

p sum_even_number_row(1)
p sum_even_number_row(2)
p sum_even_number_row(3)
p sum_even_number_row(4)
p sum_even_number_row(5)
p sum_even_number_row(6)
p sum_even_number_row(7)
p sum_even_number_row(8)
p sum_even_number_row(9)
p sum_even_number_row(10)
p sum_even_number_row(23)