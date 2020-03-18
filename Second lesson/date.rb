puts "Вберите дату"
puts "Ведите число:"
date = gets.chomp.to_i
puts "Введите месяц в числовом порядке:"
month = gets.chomp.to_i
puts "Введите год:"
year = gets.chomp.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
months[1] = 29 if ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)

sum = months.take(month - 1).sum
puts "Это #{ sum + date } день в году."
