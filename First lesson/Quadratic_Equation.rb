puts "Введите коэфицент a:"
a_coef = gets.chomp.to_f

puts "Введите коэфицент b:"
b_coef = gets.chomp.to_f

puts "Введите коэфицент c:"
c_coef = gets.chomp.to_f

discriminant = b_coef**2 - 4 * a_coef * c_coef

if discriminant > 0
  root = Math.sqrt (discriminant)
  key1 = (-b_coef + root)/(2*a_coef)
  key2 = (-b_coef - root)/(2*a_coef)
  puts "Дискриминант равен: #{discriminant}, Первый корень равен: #{key1}, Второй корень равен: #{key2}."
elsif discriminant == 0
  key = (-b_coef)/(2*a_coef)
  puts "Дискриминант равен: #{discriminant}, Корень равен: #{key}."
else
  puts "Дискриминант равен: #{discriminant}, поэтому корней нет."
end