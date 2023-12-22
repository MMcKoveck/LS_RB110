Given the munsters hash below

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
Modify the hash such that each member of the Munster family has an additional "age_group" key 
that has one of three values describing the age group the family member is in (kid, adult, or senior). 
Your solution should produce the hash below

{ "Herman" => { "age" => 32, "gender" => "male", "age_group" => "adult" },
  "Lily" => {"age" => 30, "gender" => "female", "age_group" => "adult" },
  "Grandpa" => { "age" => 402, "gender" => "male", "age_group" => "senior" },
  "Eddie" => { "age" => 10, "gender" => "male", "age_group" => "kid" },
  "Marilyn" => { "age" => 23, "gender" => "female", "age_group" => "adult" } }
Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64 and a senior is aged 65+.

PEDAC
add new KVPs
Keys are all'age_group', Values are 1 of 3, 'k,a,s'
munsters["age_group"] = 'kid', 'adult', 'senior'

munsters["age"] == 0..17  => 'kid'
                   18..64 => 'adult'
                   x > 65 => 'senior'
value of munster hash age key determines value selection
maybe make a method that checks for range and assigns new KVPs
map the hash, (or just check the age keys) each element will have a conditional (or a case?)
  resulting in main hash addition
munsters is a hash, and it's' values are also hashes.
I have to check and amend the sub hashes.
1 define the method with 1 parameter
2 access each key
3 in each key, evaluate 'age'
4 generate appropriate kvp to add to each top level value hash

def add_group(hash)
  hash.each_value do|sub_hash| 
    if sub_hash['age'] >= 0 && sub_hash['age'] <= 17
      sub_hash['age_group'] = 'kid'
    elsif sub_hash['age'] >= 18 && sub_hash['age'] <= 64
      sub_hash['age_group'] = 'adult'
    else 
      sub_hash['age_group'] = 'senior'
    end
  end
end
# MAYBE INSTEAD OF &&, USE A RANGE? INCLUDE? ?
(0..17).include?(sub_hash['age'])

# THIS IS A TEMPLATE
  # hash['age'] do |x|
  #   if x >= 0 && x <= 17
  #     hash['age_group'] = 'kid'
  #   elsif x >= 18 && x

# THIS WILL ALSO WORK. USES RANGE.include?
munsters.each_value do |sub_hash|
  if (0..17).include?(sub_hash['age'])
    sub_hash['age_group'] = 'kid'
  elsif (18..64).include?(sub_hash['age'])
    sub_hash['age_group'] = 'adult'
  else
    sub_hash['age_group'] = 'senior'
  end
end

# TRY A CASE INSTEAD OF CONDITIONAL
munsters.each do |name, stats|
  case stats['age']
  when 0..17
    stats['age_group'] = 'kid'
  when 18..64
    stats['age_group'] = 'adult'
  else
    stats['age_group'] = 'senior'
  end
end