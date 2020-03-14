puts "Введите сторону a:"
side_a = gets.chomp.to_i

puts "Введите сторону b:"
side_b = gets.chomp.to_i

puts "Введите сторону c:"
side_c = gets.chomp.to_i

if (side_a > side_b)&&(side_a > side_c)
  hip = side_a
  cat1 = side_b
  cat2 = side_c
elsif (side_b > side_a)&&(side_b > side_c)
  hip = side_b
  cat1 = side_a
  cat2 = side_c
else
  hip = side_c
  cat1 = side_a
  cat2 = side_b
end

if (hip**2) == (cat1**2) + (cat2**2)
  puts "Прямоугольный реугольник"
elsif (side_a == side_b)&&(side_a != side_c)||(side_b == side_c)&&(side_b != side_a)||(side_c == side_a)&&(side_c != side_b)
  puts "Равнобедренный треугольник"
elsif (side_a == side_b)&&(side_a == side_c)
  puts "Равносторонний треугольник"
else
  puts "Попробуй подобрать другие значения"
end

