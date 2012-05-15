class Board
  
  def initialize
    @slots = [1,2,3,4,5,6,7,8,9]
    # @win_combos = [
    #   ['1', '2', '3','4','5','6','7','8', '9'],
    #   ['1', '2', '3','4','5','6','7','8', '9'],
    # ]
    
    greeting
    @user = "X"
    @computer = "O"
    draw_board
    user_move
  end
  
  def greeting
    # Greeting 
    puts '#####################################################################'
    puts " "
    @computer_name = "Baxter"
    puts "Hello, my name is #{@computer_name} and welcome to the Groupon TIC-TAC-TOE challenge!"
    puts ""
    puts "Before we get started, what is your name?"
    @user_name = gets.chomp
    puts '-----------------------------------------------------------------------------------------------'
    puts "Nice to meet you #{@user_name.capitalize}, I hope you're ready because I don't plan on loosing!"
  end
  
  def draw_board
    puts '------------------------------------------------------------------'
    puts "#{@user_name}: #{@user}"
    puts " VS."
    puts "#{@computer_name}: #{@computer}"
    puts '------------------------------------------------------------------'
    puts 'Directions: make a move by entering the number that represents the'
    puts "slot you're trying to fill. For example, '1' , '5', '9', etc."
    puts ' '
    puts '------------------------------------------------------------------'
    print "\n"
    print " #{@slots[0]}  |"
    print " #{@slots[1]}  |"
    print " #{@slots[2]}"
    print "\n------------\n"
    print " #{@slots[3]}  |"
    print " #{@slots[4]}  |"
    print " #{@slots[5]}"
    print "\n------------\n"
    print " #{@slots[6]}  |"
    print " #{@slots[7]}  |"
    print " #{@slots[8]}"
    print "\n"
  end

  
  def user_move
    puts "#{@user_name.upcase} please make your move"
    move = gets.chomp.to_i 
    @slots[move-1] = @user
    draw_board
  end

  
end

Board.new