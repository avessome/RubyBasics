puts "Enter your name:"
name = gets.chomp

puts "Enter your height:"
height = gets.chomp.to_i

ideal_weight = (height-110)*1.15

if ideal_weight <= 0
  puts "Your weight is OK, #{name}!"
else
  puts "#{name}, your ideal weight is #{ideal_weight}."
end