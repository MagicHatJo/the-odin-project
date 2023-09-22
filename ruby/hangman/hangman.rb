require 'yaml'

DICTIONARY_FILE = "minimum_5.txt"
ASCII_ART = ['''






  =========''', '''
    +---+
    |   |
        |
        |
        |
        |
  =========''', '''
    +---+
    |   |
    O   |
        |
        |
        |
  =========''', '''
    +---+
    |   |
    O   |
    |   |
        |
        |
  =========''', '''
    +---+
    |   |
    O   |
   /|   |
        |
        |
  =========''', '''
    +---+
    |   |
    O   |
   /|\  |
        |
        |
  =========''', '''
    +---+
    |   |
    O   |
   /|\  |
   /    |
        |
  =========''', '''
    +---+
    |   |
    O   |
   /|\  |
   / \  |
        |
  ========='''
]

class Hangman

	def initialize(hidden_word = nil, guessed = nil, board = nil, lives = nil)
		load_dictionary(DICTIONARY_FILE) unless hidden_word
		@hidden_word = hidden_word || get_random_word()
		@guessed     = guessed     || create_guessed_pool()
		@board       = board       || Array.new(@hidden_word.length, "_")
		@lives       = lives       || 7
	end

	def play()
		until game_over() do
			draw()
			input = get_input()
			case input
			when "save"
				save_state()
			when "exit"
				exit
			else
				@lives -= update(input)
			end
		end

		draw()
		if @live <= 0 then
			puts "Game Over"
			puts "The word was #{@hidden_word}" if @lives <= 0
		else
			puts "Congratulations!"
		end
	end

	def self.load_from_yaml(filename)
		data = YAML.load_file(filename)
		new(data[:hidden_word],
			data[:guessed],
			data[:board],
			data[:lives]
		)
	end

	private

	def load_dictionary(filename)
		File.open(filename, 'r') do |file|
			@dictionary = file.read().split("\n")
		end
	end

	def get_random_word()
		return @dictionary.sample
	end

	def create_guessed_pool()
		guessed = {}
		('a'..'z').each { |letter| guessed[letter] = false }
		return guessed
	end

	def game_over()
		return true if @lives <= 0
		return true if @board.none? { |char| char == "_" }
		return false
	end

	def draw()
		puts ASCII_ART[7 - @lives]
		('a'..'m').each { |c| print @guessed[c] ? "#{c} " : "\e[90m#{c}\e[0m " }
		puts
		('n'..'z').each { |c| print @guessed[c] ? "#{c} " : "\e[90m#{c}\e[0m " }
		puts
		@board.each { |letter| print "#{letter} " }
		puts
		puts "You have #{@lives} attempts remaining"
	end

	def get_input()
		def is_valid?(input)
			(/^[a-z]$/.match?(input) && !@guessed[input])
		end

		input = ""
		until is_valid?(input) do
			print "Enter your guess: "
			input = gets.chomp.downcase
			return input if ["save", "exit"].include?(input)
		end
		@guessed[input] = true
		return input
	end

	def update(input)
		lives_to_lose = 1
		@board = @board.map.with_index do |char, i|
			if @hidden_word[i] == input then
				lives_to_lose = 0
				input
			else
				char
			end
		end
		return lives_to_lose
	end

	def to_yaml()
		YAML.dump({
			hidden_word: @hidden_word,
			guessed:     @guessed,
			board:       @board,
			lives:       @lives
		})
	end

	def save_state()
		print "Name your save file: "
		input = gets.chomp
		File.open(input, 'w') do |file|
			file.puts to_yaml()
		end
	end

	def self.check_save_data()
		print "Enter save data to load (Blank to skip): "
		input = gets.chomp.strip
		return input == "" ? false : input
	end
end

if $PROGRAM_NAME == __FILE__
	if save_file = Hangman.check_save_data() then
		hangman = Hangman.load_from_yaml(save_file)
	else
		hangman = Hangman.new()
	end
	hangman.play()
end