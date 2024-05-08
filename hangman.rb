

class Hangman
  attr_accessor :secret_word, :number_of_guesses, :display

  def initialize
    @secret_word = generate_secret_word
    @number_of_guesses = 10
    @display = Array.new(@secret_word.size, '_')
  end

  private

  def generate_secret_word
    file = File.open('dictionary.txt')
    dictionary = File.readlines(file).map(&:chomp).select { |word| word.length.between?(5, 12) }
    file.close
    dictionary.sample
  end
end

game = Hangman.new
puts "Guess a letter"
guess = gets.chomp

if game.secret_word.include?(guess)
  index_list = (0...game.secret_word.length).select { |i| game.secret_word[i] == guess }
  index_list.each { |i| game.display[i] = guess }
else
game.number_of_guesses -= 1
end

p game.display