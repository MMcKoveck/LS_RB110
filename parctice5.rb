In the array:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

Find the index of the first name that starts with "Be"



flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.select {|name| name.start_with?('Be')}  # => "Betty"
flintstones.index.start_with?('Be')                 # => ERROR

flintstones.index {|x| x.start_with?('Be')}         # => 3

#=begin THEIR CODE
flintstones.index {|name| name[0, 2] == 'Be'}
find the index of block variable name, sliced, starting at index 0, 2 chars long, that equivalates to 'Be'
