class TicTacToe
    WIN_COMBINATIONS = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], # Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], # Columns
      [0, 4, 8], [2, 4, 6]              # Diagonals
    ].freeze
  
    def initialize
      @board = Array.new(9, " ")
      @current_player = "X"
      @turns_played = 0
    end
  
    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
      puts "\n"
    end
  
    def input_to_index(input)
      input.to_i - 1
    end
  
    def move(index, token = "X")
      @board[index] = token
    end
  
    def position_taken?(index)
      @board[index] != " "
    end
  
    def valid_move?(position)
      position.between?(0, 8) && !position_taken?(position)
    end
  
    def turn_count
      @board.count { |cell| cell != " " }
    end
  
    def current_player
      turn_count.even? ? "X" : "O"
    end
  
    def turn
      puts "Please enter a position (1-9):"
      input = gets.chomp
      index = input_to_index(input)
  
      if valid_move?(index)
        move(index, current_player)
        display_board
      else
        puts "Invalid move. Please try again."
        turn
      end
    end

    def won?
        WIN_COMBINATIONS.each do |combination|
          pos1 = combination[0]
          pos2 = combination[1]
          pos3 = combination[2]
    
          if @board[pos1] == @board[pos2] && @board[pos1] == @board[pos3] && @board[pos1] != " "
            return combination
          end
        end
    
        false
    end

    def full?
        @board.all? { |cell| cell == "X" || cell == "O" }
    end

    def draw?
        full? && !won?
    end

    def over?
        full? && won?
    end

    def winner
        if winning_combination = won?
          @board[winning_combination[0]]
        end
    end

    def play
        until over?
          turn
        end
    
        if won?
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"
        end
      end

  end
  