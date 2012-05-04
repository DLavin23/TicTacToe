class TicTacToe
  
  attr_accessor :slots, :win_combos
  
  def initialize(play_game = false)
    
    # possible moves on the board
    @slots = {
      "a1"=>" ", "a2"=>" ", "a3"=>" ",
      "b1"=>" ", "b2"=>" ", "b3"=>" ",
      "c1"=>" ", "c2"=>" ", "c3"=>" ", 
    }
    
    # possible winning combinations
    @win_combos = [
      ['a1', 'a2', 'a3'],
      ['b1', 'b2', 'b3'],
      ['c1', 'c2', 'c3'],
      
      ['a1', 'b1', 'c1'],
      ['a2', 'b2', 'c2'],
      ['a3', 'b3', 'c3'],
      
      ['a1', 'b2', 'c3'],
      ['c1', 'b2', 'a3']
    ]
    
    @board = Board.new
    @computer = Computer.new
    
    
    User.new(@board,@computer)
    Computer.new
    Board.new(@computer)
    
    
    @user = 'X'
    @computer = 'O'
    @computer_name = "Baxter"
    if play_game
      greeting
      user_move
      computer_move
    end 
  end
  
  def greeting
    # Welcome message to start the game
    puts '#####################################################################'
    puts " "
    @computer_name = "Baxter"
    puts "Hello, my name is #{@computer_name} and welcome to the Groupon TIC-TAC-TOE challenge!"
    puts ""
    puts "Before we get started, what is your name?"
    @user_name = gets.chomp
    puts '------------------------------------------------------------------'
    puts "Nice to meet you #{@user_name.capitalize}, I hope you're ready because I don't plan on loosingl!"
  end
end

class User
  
  def initialize(board, computer)
    @board = board
    @computer = computer
  end
  
  def user_move
   @board.draw_board
   puts "#{@user_name.upcase} please make your move."
   move = gets.chomp.downcase
    
    return wrong_input unless move.length == 2 
      x = move.split("")
      if(['a','b','c'].include? x[0])
        if(['1','2','3'].include? x[1])
          if @slots[move] == " "
            @slots[move] = @user
            puts '------------------------------------------------------------'
            puts "#{@user_name} marks #{move}"
          else
            wrong_move
          end
        else
          wrong_input
        end
      else
        wrong_input
      end
    @computer.computer_move
  end
  
  def wrong_input
    puts "Please specify a move with the format 'A1' , 'B3' , 'C2' etc."
    user_move
  end
  
  def wrong_move
    puts "You must choose an empty slot"
    user_move
  end
	
	def moves_remaining
    slots = 0
    @slots.each do |key, value|
      slots += 1 if value == " "
    end
    slots
  end
end

class Computer
	
	def initialize(board)
     @board = board
  end
	
	def computer_move
	  if @slots.any? == 'X'
      computer_first_move
    else
      # need to write method to look for a corner
      move = find_move
      @slots[move] = @computer
      puts '---------------------------------------------------------------------'
      puts "#{@computer_name} marks #{move}"
      check_board(@user)
    end
  end
  
  def computer_first_move
    if @slots['a1'] == 'X'
      @slots['c1'] = @computer
    else
      @slots['a1'] = @computer
    end
    user_move
  end
  
  def middle_block
    array = @slots.to_a
    x = array[4]
    if x[1] != 'X' #computer should select the middle slot
      @slots['b2'] = @computer
      draw_board
      user_move
    else
      puts 'middle is taken' # method to make another selection
    end
  end
  
  def find_move
    # check to see if computer can win
    # check to see if any slots already have 2 filled by computer
    @win_combos.each do |option|
      if times_in_slot(option, @computer) == 2
        return empty_slot option
      end
    end
    
    # check to see if user can win
    # check to see if any slots already have 2 filled by user
    @win_combos.each do |option|
      if times_in_slot(option, @user) == 2
        return empty_slot option
      end
    end
    
    #see if any slots already have 1 filled by computer
    @win_combos.each do |option|
      if times_in_slot(option, @computer) == 1
        return empty_slot option
      end
    end
    
    # no strategic moves available, selects any open slot
    random_move
  end
  
  def random_move
    key = @slots.keys;
    move = rand(key.length)
    if @slots[key[move]] == " "
      return key[move]
    else
      @slots.each { |key,value| return key if value == " "}
    end
  end

  def times_in_slot slot, letter
    times = 0
    slot.each do |x|
      times += 1 if @slots[x] == letter
      unless @slots[x] == letter || @slots[x] == " "
        return 0
      end
    end
    times
  end
  
  def empty_slot slot
    slot.each do |x|
      if @slots[x] == " "
        return x
      end
    end
  end
end

class Board  
  
    def draw_board
    puts '------------------------------------------------------------------'
    puts "#{@user_name}: #{@user}"
    puts " VS."
    puts "#{@computer_name}: #{@computer}"
    puts '------------------------------------------------------------------'
    puts 'Directions: make a move by entering the letter & number representing'
    puts "the slot you're trying to fill. For example, 'a1' , 'b2', 'c3', etc."
    puts ' '
    puts '------------------------------------------------------------------'
    puts "   a b c"
    puts ' '
    puts " 1 #{@slots["a1"]}|#{@slots["b1"]}|#{@slots["c1"]}"
    puts '   ------'
    puts " 2 #{@slots["a2"]}|#{@slots["b2"]}|#{@slots["c2"]}"
    puts '   ------'
    puts " 3 #{@slots["a3"]}|#{@slots["b3"]}|#{@slots["c3"]}"
    puts '------------------------------------------------------------------'
  end
  
  def check_board(next_move)
    
    game_over = nil
    
    @win_combos.each do |slot|
      # check to see if computer has won
      if times_in_slot(slot, @computer) == 3
        puts "GAME OVER... #{@computer_name} wins....he always does!"
        game_over = true
      end
      
      # check to see if user has won
      if times_in_slot(slot, @user) == 3
        puts "GAME OVER... #{@user_name} wins...I've made a terrible mistake!"
        game_over = true
      end
    end
    
    unless game_over
      if(moves_remaining > 0)
        if(next_move == @user)
          user_move
        else
          computer_move
        end
      else
        puts "CAT'S GAME, try again!"
      end
    end
  end  
end

TicTacToe.new(true)