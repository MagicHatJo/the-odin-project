class Piece

	attr_reader :id

	def initialize(id)
		@id = id
		@color = { "X" => "\e[31m", "O" => "\e[34m" }[id]
	end

	def to_s
		"#{@color}#{@id}\e[0m"
	end

	def ==(other)
		return false unless other.is_a?(Piece)
		@id == other.id
	end

end

class Board

	def initialize()
		@board = Array.new(3) { Array.new(3, " ") }
	end

	def draw
		puts " #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} "
		puts "---+---+---"
		puts " #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} "
		puts "---+---+---"
		puts " #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}"
	end

	def is_available?(x, y)
		@board[y][x] == " "
	end

	def set_piece(x, y, piece)
		@board[y][x] = piece
	end

	# End Conditions
	def found_tie?()
		!@board.any? { |row| row.any? { |element| element.is_a?(String) } }
	end

	def found_row?()
		@board.any? { |row| row[0] != " " && row.uniq{ |p| p.id if p.is_a?(Piece) }.length == 1 }
	end

	def found_col?()
		@board.transpose.any? { |col| col[0] != " " && col.uniq{ |p| p.id if p.is_a?(Piece) }.length == 1 }
	end

	def found_diag?()
		@board[1][1] != " " && (
			[@board[0][0], @board[1][1], @board[2][2]].uniq{ |p| p.id if p.is_a?(Piece) }.length == 1 ||
			[@board[2][0], @board[1][1], @board[0][2]].uniq{ |p| p.id if p.is_a?(Piece) }.length == 1
		)
	end

end

class TicTacToe

	def initialize()
		@board = Board.new()
		@turn = 0
		@players = ["X", "O"].shuffle
	end

	def play()
		until game_over() do
			update_screen()
			@board.draw()
			user_input = get_user_input()
			@board.set_piece(user_input[:x], user_input[:y], Piece.new(@players[@turn]))
			@turn = (@turn + 1) % 2
		end
		display_results()
	end

	def game_over()
		@board.found_row?  ||
		@board.found_col?  ||
		@board.found_diag? ||
		@board.found_tie?
	end

	def get_user_input()

		def is_valid?(input)
			!!(input =~ /^[0-2] [0-2]$/)
		end

		user_input = ""
		until is_valid?(user_input) &&
			  @board.is_available?(user_input[0].to_i, user_input[2].to_i) do
			print "Enter a coordinate (x y): "
			user_input = gets.chomp
		end
		{x: user_input[0].to_i, y: user_input[2].to_i}
	end

	def update_screen()
		system("clear") || system("cls")
		puts "Current player: #{@players[@turn]}"
	end

	def display_results()
		system("clear") || system("cls")
		puts ""
		@board.draw()
	end

end

if $PROGRAM_NAME == __FILE__
	tic_tac_toe = TicTacToe.new()
	tic_tac_toe.play()
end