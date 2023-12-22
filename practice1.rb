=begin flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
Turn this array into a hash where the names are the keys and the values are the positions in the array.
=end

# flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# fHash = flintstones.each_with_index do |name, idx|
#   hash = {}            #  THIS LINE SHOULD BE OUTSIDE THE BLOCK!!!
#   hash[name] = idx
# end
# p fHash
# OK SO, I PUT THE HASH CREATION IN THE WRONG PLACE!!

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

fHash = flintstones.each_with_object({}) do |name, hash|
  hash[name] = flintstones.index(name)
end
p fHash

# THEIR CODE
flintstones_hash = {}
flintstones.each_with_index do |name, index|
  flintstones_hash[name] = index
end