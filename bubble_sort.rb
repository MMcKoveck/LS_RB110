Write a method that takes an Array as an argument, 
and sorts that Array using the bubble sort algorithm as just described. 
Note that your sort will be "in-place"; that is, you will mutate the Array passed as an argument. 
You may assume that the Array contains at least 2 elements.

Examples:

array = [5, 3]
bubble_sort!(array)
array == [3, 5]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
array == [1, 2, 4, 6, 7]

array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
bubble_sort!(array)
array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)

#=begin THEIR CODE

def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      next if array[index - 1] <= array[index]
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
end

Our outer loop handles the task of repeating iterations until the Array is completely sorted. 
It terminates the first time we iterate through all comparisons without making any swaps, 
which we keep track of through the swapped variable.

The inner loop takes care of looking at every pair of consecutive elements 
and swapping them if the first element of a pair is greater than the second. 
We use the usual ruby idiom for swapping two values, e.g.,

a, b = b, a