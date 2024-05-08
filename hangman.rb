file = File.open('dictionary.txt')
dictionary = File.readlines(file).map(&:chomp)
