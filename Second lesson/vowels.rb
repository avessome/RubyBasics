hash = {}

alphabet = ('a'..'z').to_a

vowels = ["a", "e", "i", "o", "u", "y"]

alphabet.each.with_index(1) { |letter, index| hash[letter] = index if vowels.include? letter }

puts hash