puts "Вберите дату"
puts "Ведите число:"
date = gets.chomp.to_i
puts "Введите месяц в числовом порядке:"
month = gets.chomp.to_i
puts "Введите год:"
year = gets.chomp.to_i

array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
array[1] = 29 if ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0 )

sum = array.take(month - 1).sum
puts "Это #{sum + date} день в году."