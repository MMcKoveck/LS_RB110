Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"

ex:

{ "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }


statement = "The Flintstones Rock"

statement.chars.each_with_object({}) do|char, hash|
  hash[char] += 1
end
# THIS GIVES A nil ERROR BECAUSE THE INCLUDED HASH OBJECT DOESNT HAVE A DEFAULT VALUE OF 0.
# THAT MUST BE ASSIGNED SOMEWHERE FIRST
#=begin THEIR CODE
result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a

letters.each do |letter|
  letter_frequency = statement.count(letter)
  result[letter] = letter_frequency if letter_frequency > 0
end

# MY CODE WITH VALUE ASSIGNED INITIALLY
statement = "The Flintstones Rock"

frequency = Hash.new(0)
statement.chars.each_with_object(frequency) do |char, hash|
  hash[char] += 1
end

# THIS MUTATES frequency 

#=New Try USE THIS TO SET THE DEFAULT VALUES TO 0
result = Hash.new(0)

irb(main):092:0> result = Hash.new(0)
=> {}
irb(main):093:0> result['test'] += 1
=> 1
irb(main):094:0> result
=> {"test"=>1}
irb(main):095:0> result['test'] += 1
=> 2
irb(main):096:0> result['test'] += 1
=> 3
irb(main):097:0> result
=> {"test"=>3}

