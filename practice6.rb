Write code that changes the array below so that all of the names are shortened to just the first three characters. 
Do not create a new array.

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.map! {|x| x[0,3]}
