class Grid
  attr_reader :board

  def initialize
    @board = Array.new(9)
  end

  def print_grid
    @board.each_with_index do |element, index|
      # Replace nil with a space for printing
      print element.nil? ? " " : element
      # Add a vertical bar unless it's the last column
      print "|" unless (index + 1) % 3 == 0
      # Go to the next line after every third column, except for the last one
      puts if (index + 1) % 3 == 0 && index < 8
    end
  end

  def update_grid(index, value)
    @board[index] = value
  end
end

class TicTacToe
  def initialize
    @grid = Grid.new
    # The first player is X
    @current_player = "X"   
    @winning_combinations = [[0,1,2], [3,4,5], [6,7,8],
                             [0,3,6], [1,4,7], [2,5,8],
                             [0,4,8], [2,4,6]]                     
  end

  def check_winner
    grid_board = @grid.board
    # Check if all three elements in the combination are the same and not nil
    @winning_combinations.each do |combo|
      if grid_board[combo[0]] == grid_board[combo[1]] &&
         grid_board[combo[1]] == grid_board[combo[2]] &&
         !grid_board[combo[0]].nil?
         # Return the winning symbol
         return grid_board[combo[0]]
      end
    end
    # Return nil if there is no winner
    return nil
  end  
  
  def check_draw
    # Check if no element in the grid is nil,
    # meaning all cells are occupied.
    # Returns true if it's a draw.
    @grid.board.none?(&:nil?)
  end

  def play 
    loop do
      @grid.print_grid
      puts "\nIt's #{@current_player}'s turn. Choose a number between 1 and 9:"
      choice = nil

      loop do
        input = gets.chomp
        # Check if the input is a number between 1 and 9
        if input.match?(/^[1-9]$/)
          # Convert the input to an array index from 0 to 8
          choice = input.to_i - 1
          break
        # If a valid number is not entered, print the error message
        else
          puts "Please enter a valid number between 1 and 9"
        end
      end
      # Check if the chosen cell is empty and update the grid
      if @grid.board[choice].nil?
        @grid.update_grid(choice, @current_player)
        # If there is a winner, print the message
        if check_winner
          @grid.print_grid
          puts "\n#{@current_player} wins!"
          break
        # If there is a draw, print the message
        elsif check_draw
          @grid.print_grid
          puts "\nIt's a draw!"
          break
        end
        # Switch player from X to O
        @current_player = @current_player == "X" ? "O" : "X"
      # If the selected cell is occupied, print the error message
      else
        puts "Cell already taken. Choose another cell."
      end
    end
  end
end

if __FILE__ == $0
  game = TicTacToe.new
  game.play
end
