class Player

	def get_input(message)
		input = ""
		until input =~ /^[RYGBPO]{4}$/ do
			print message
			input = gets.chomp.upcase
		end
		return input.split("")
	end

	def set_password()
		get_input("Set Password: ")
	end
end

class Computer
	
	def initialize()
		@colors = "RYGBPO".chars
		@possible_codes = initialize_possible_codes()
		@last_guess = @possible_codes.sample
	end

	def get_input(last_guess_status)
		locked = Array.new
		last_guess_status.each_with_index do |check, i|
			if check == "G" then
				@possible_codes.reject! { |code| code[i] != @last_guess[i] }
				locked.push(@last_guess[i])
			elsif check == "Y" then
				@possible_codes.reject! { |code| code[i] == @last_guess[i] }
				locked.push(@last_guess[i])
			end
		end

		last_guess_status.each_with_index do |check, i|
			if check == "R" then
				for k in 0...4
					@possible_codes.reject! do |code|
						code[k] == @last_guess[i] && !locked.include?(@last_guess[i])
					end
				end
			end
		end

		@last_guess = @possible_codes.sample
		return @last_guess
	end

	def set_password()
		return Array.new(4) { @colors.sample }
	end

	private

	def initialize_possible_codes()
		return @colors.repeated_permutation(4).to_a
	end
end

class Piece
	attr_reader :id

	def initialize(id)
		@id = id
		set_color()
	end

	def id=(new_id)
		@id = new_id
		set_color()
	end

	def ==(other)
		case other
		when Piece
			return @id == other.id
		when String
			return @id == other
		end
		return false
	end

	def to_s
		"#{@color}●\e[0m"
	end

	private

	def set_color()
		@color = {
			"R" => "\e[31m",
			"G" => "\e[32m",
			"Y" => "\e[33m",
			"B" => "\e[34m",
			"P" => "\e[35m",
			"O" => "\e[38;5;208m",
			"?" => "\e[90m"
		}[@id]
	end
end

class Board
	attr_reader   :last_guess_status
	attr_writer   :password
	attr_accessor :current_row

	def initialize()
		@board = Array.new(12) { Array.new(4, Piece.new("?")) }
		@last_guess_status = Array.new(4) { Piece.new("?") }
		@current_row = 11
		make_legend()
	end

	def password=(new_password)
		if new_password.is_a?(String) then
			new_password = new_password.map { |piece| Piece.new(piece) }
		end
		@password = new_password
	end

	def draw()
		system("clear") || system("cls")
		@last_guess_status.each { |piece| print "|#{piece}"}
		puts"|"
		puts "---------"
		@board.each_with_index do |row, i|
			puts "|#{row[0]}|#{row[1]}|#{row[2]}|#{row[3]}|  #{@legend[i]}"
		end
	end

	def check_input(input_arr)
		counter = Hash.new(0)

		@last_guess_status.map.with_index do |piece, i|
			if @password[i] == input_arr[i] then
				piece.id = "G"
				counter[input_arr[i]] += 1
			end
		end

		@last_guess_status.map.with_index do |piece, i|
			unless @password[i] == input_arr[i] then
				if (@password.include?(input_arr[i]) &&
					counter[input_arr[i]] < @password.count(input_arr[i]))
					piece.id = "Y"
				else
					piece.id = "R"
				end
				counter[input_arr[i]] += 1
			end
			piece
		end
	end

	def place(input_arr)
		@board[@current_row] = @board[@current_row].map.with_index { |_, i| Piece.new(input_arr[i]) }
	end

	private

	def make_legend()
		@legend = Array.new(12)
		@legend[5]  = "\e[31m R - ●\e[0m"
		@legend[6]  = "\e[32m G - ●\e[0m"
		@legend[7]  = "\e[33m Y - ●\e[0m"
		@legend[8]  = "\e[34m B - ●\e[0m"
		@legend[9]  = "\e[35m P - ●\e[0m"
		@legend[10] = "\e[38;5;208m O - ●\e[0m"
	end
end

class Mastermind

	def initialize()
		@runner     = nil
		@mastermind = nil
		@board = Board.new()
	end

	def play()
		pick_sides()
		@board.password = @mastermind.set_password()

		until game_over() do
			@board.draw()
			input_arr = @runner.get_input(
				@runner.is_a?(Player) ?
				"Next Attempt : ": @board.last_guess_status
			)
			@board.check_input(input_arr)
			@board.place(input_arr)
			@board.current_row -= 1
			sleep(1) if @runner.is_a?(Computer)
		end

		@board.draw()
	end

	private

	def pick_sides()
		input = ""
		until ["r", "m"].include?(input) do
			print "Are you the (R)unner or the (M)astermind? "
			input = gets.chomp.downcase
		end
		@runner     = input == "r" ? Player.new() : Computer.new()
		@mastermind = input == "m" ? Player.new() : Computer.new()
	end

	def game_over()
		return (
			@board.last_guess_status.all? { |piece| piece == "G" } ||
			@board.current_row < 0
		)
	end
end

if $PROGRAM_NAME == __FILE__
	mastermind = Mastermind.new()
	mastermind.play()
end