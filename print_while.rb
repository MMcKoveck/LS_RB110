# numbers = []

# while numbers.length < 5
#   numbers << rand(0..99)
# end

# puts numbers

# numbers = [7,9,13,25,18]

# until numbers == []
#   puts numbers.shift
# end

# friends = ['Sarah', 'John', 'Hannah', 'Dave']

# for f in friends
#   puts "Hello, #{f}!"
# end

count = 1

loop do
  count.odd? ? puts("#{count} is odd!") : puts("#{count} is even!")
  puts count.odd? ? "#{count} is odd!" : "#{count} is even!"
  count += 1
  break if count > 5
end