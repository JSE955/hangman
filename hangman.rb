require 'json'

class Hangman
  attr_accessor :secret_word, :number_of_guesses, :display, :incorrect_letters

  def initialize(secret_word = generate_secret_word,
                 number_of_guesses = 10,
                 display = Array.new(secret_word.size, '_'),
                 incorrect_letters = [])
    @secret_word = secret_word
    @number_of_guesses = number_of_guesses
    @display = display
    @incorrect_letters = incorrect_letters
  end

  def to_json(*_args)
    JSON.dump({
      secret_word: secret_word,
      number_of_guesses: number_of_guesses,
      display: display,
      incorrect_letter: incorrect_letters
    })
  end

  def self.from_json(string)
    data = JSON.load string
    self.new(data['secret_word'], data['number_of_guesses'], data['display'], data['incorrect_letters'])
  end

  def save_game
    File.open('save_data.json', 'w') do |file|
      file.write self.to_json
    end
    puts 'Your game has been saved!'
  end

  def show_display
    puts "Secret Code: #{display.join(' ')}"
    print 'Incorrect Guesses: '
    if incorrect_letters.empty?
      puts 'None'
    else
      puts incorrect_letters.join(' ')
    end
    puts "Guesses Remaining: #{number_of_guesses}"
    puts
  end

  def take_turn
    puts 'Guess a letter (or enter SAVE to save progress):'
    letter = gets.chomp.downcase
    if letter == 'save'
      save_game
      take_turn
    elsif incorrect_letters.include?(letter) || display.include?(letter)
      puts "#{letter} was already guessed."
      take_turn
    elsif secret_word.include?(letter)
      index_list = (0...secret_word.length).select { |i| secret_word[i] == letter }
      index_list.each { |i| display[i] = letter }
    else
      self.number_of_guesses = number_of_guesses - 1
      incorrect_letters.push(letter)
    end
  end

  def play
    puts 'Welcome to Hangman!'
    puts '--------------'
    show_display
    until number_of_guesses.zero?
      take_turn
      if display.none?('_')
        puts "YOU WIN! Secret Word is #{secret_word}"
        return
      end
      show_display
    end
    puts "YOU LOSE! Secret Word was #{secret_word}"
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
game.play
