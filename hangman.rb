file = File.open('dictionary.txt')
dictionary = File.readlines(file).map(&:chomp).select { |word| word.length.between?(5, 12) }
secret_word = dictionary.sample
p secret_word
