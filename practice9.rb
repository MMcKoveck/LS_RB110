words = "the flintstones rock"
would be:
words = "The Flintstones Rock"
Write your own version of the rails titleize implementation.

words = "the flintstones rock"
words.split.capitalize!.join(' ') # CLOSE BUT CANT CAPITALIZE AN ARRAY
                                  # GOTTA MUTATE THAT ARRAY AND MUTATE THE STRINGS
                                  # BEFORE REJOINING WITH SPACES

words.split.map! {|x| x.capitalize!}.join(' ')

THEYRE SAYING I DONT NEED TO MUTATE..

words.split.map { |word| word.capitalize }.join(' ')

HUH. 
TURNS OUT MY CODE ON LINE 11 IS _NOT_ MUTATING,
SO THE !s ARE UNNECESSARY.

words = words.split.map {|x| x.capitalize}.join(' ')
# GOTTA DO THAT TO REASSIGN, AND NO !s.