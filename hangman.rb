file = File.open('dictionary.txt')
dictionary = File.readlines(file).map(&:chomp).select { |word| word.length.between?(5, 12) }
secret_word = dictionary.sample

display = Array.new(secret_word.size, '_')
p secret_word
puts "Guess a letter"
guess = gets.chomp

if secret_word.include?(guess)
  index_list = (0...secret_word.length).select { |i| secret_word[i] == guess }
  index_list.each { |i| display[i] = guess }
end

p display
