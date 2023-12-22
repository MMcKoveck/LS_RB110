You have a bank of switches before you, numbered from 1 to n. 
Each switch is connected to exactly one light that is initially off. 
You walk down the row of switches and toggle every one of them. 
You go back to the beginning, and on this second pass, you toggle switches 2, 4, 6, and so on. 
On the third pass, you go back again to the beginning and toggle switches 3, 6, 9, and so on. 
You repeat this process and keep going until you have been through n repetitions.

Write a method that takes one argument, the total number of switches, 
and returns an Array that identifies which lights are on after n repetitions.

Example with n = 5 lights:

round 1: every light is turned on
round 2: lights 2 and 4 are now off; 1, 3, 5 are on
round 3: lights 2, 3, and 4 are now off; 1 and 5 are on
round 4: lights 2 and 3 are now off; 1, 4, and 5 are on
round 5: lights 2, 3, and 5 are now off; 1 and 4 are on
The result is that 2 lights are left on, lights 1 and 4. The return value is [1, 4].

With 10 lights, 3 lights are left on: lights 1, 4, and 9. The return value is [1, 4, 9].


# PEDAC
input : integer
output : array of 'ON' lights 
def blinky_lights(n)
  array to iterate through
  array = (1..n).to_a
  need to change iteration |item| % 1..n

  need an on state and an off state 1,0 or 'ON','OFF' ?
state change helper method

return the square of every item in range if still in range

(1..n).map {|x| x*x if (1..n).include?(x*x)}.compact


def blinky_lights(n)
  (1..n).map { |x| x * x if (1..n).include?(x * x) }.compact
end

/Users/balloon/Launch_School/LS_R101_Lesson_2/1000_lights.rb