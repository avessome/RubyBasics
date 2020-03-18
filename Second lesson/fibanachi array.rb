fibonacci_array = [0, 1]

element = 1

while element < 100
  fibonacci_array << element
  element = fibonacci_array[-1] + fibonacci_array[-2]
end

puts fibonacci_array