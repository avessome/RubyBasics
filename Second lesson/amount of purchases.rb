busket = { }
total_price = 0

loop do
  puts "Enter the name of the product"
  name = gets.chomp
  puts "Enter the cost"
  cost = gets.chomp.to_f
  puts "Enter the quantity"
  quantity = gets.chomp.to_i
  busket[name] = { cost: cost, quantity: quantity }
  puts  "If there are no more products enter 'stop', else press 'Enter'."
  break if gets.chomp == "stop"
end

puts "Your purchases:"
busket.each do |name, value|
  puts "#{ name } - quantity: #{ value[:quantity] } -price: #{ value[:cost] } - total price: #{ total = value[:quantity] * value[:cost] }"
  total_price += total
end

puts "Total price: #{ total_price }"
