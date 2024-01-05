###################################
######      BASIC STUFF      ######
###################################

winning_groups = ['123', '456', '789', '147', '258', '369', '159', '357'].map! {|x| x.chars} # IN #check_for_win METHOD
open_squares = ('1'..'9').to_a

user_name = ''
user_moves = ['U']
user_choice = ''

computer_name = ''
computer_moves = ['C']
computer_choice = ''

user_win = false
computer_win = false
starting_player = 1
computer_names_array = ['MCP', 'Mother', 'HAL', 'W.O.P.R.', 'Johnny 5']
total_wins_hash = Hash.new(0)


def double_space          # ADDS 2 BLANK LINES
  puts''
  puts''
end

def space                 # ADDS 1 BLANK LINE
  puts ''
end


def set_board                                 # THIS MAKES A BLANK BOARD
  symbols = (:a..:i).to_a
  blanks = Hash.new(' ')
  hash_array = []
  9.times do 
    hash_array << symbols.zip(symbols.map {|sym| blanks[sym]}).to_h
  end
  hash_array
end

# board_hash = set_board                      # THIS SETS THE CURRENT BOARD TO BLANK # USE THIS TO START

def display_board(hashes)                   # THIS WORKS WITH board_hash # USE THIS EVERY TIME TO DISPLAY ## !!ADDED CLEAR!! ##
  system "clear"
  space
  puts " #{hashes[0][:a]}#{hashes[0][:b]}#{hashes[0][:c]} | #{hashes[1][:a]}#{hashes[1][:b]}#{hashes[1][:c]} | #{hashes[2][:a]}#{hashes[2][:b]}#{hashes[2][:c]} ".center(60)
  puts " #{hashes[0][:d]}#{hashes[0][:e]}#{hashes[0][:f]} | #{hashes[1][:d]}#{hashes[1][:e]}#{hashes[1][:f]} | #{hashes[2][:d]}#{hashes[2][:e]}#{hashes[2][:f]} ".center(60)
  puts " #{hashes[0][:g]}#{hashes[0][:h]}#{hashes[0][:i]} | #{hashes[1][:g]}#{hashes[1][:h]}#{hashes[1][:i]} | #{hashes[2][:g]}#{hashes[2][:h]}#{hashes[2][:i]} ".center(60)
  puts "-----+-----+-----".center(60)
  puts " #{hashes[3][:a]}#{hashes[3][:b]}#{hashes[3][:c]} | #{hashes[4][:a]}#{hashes[4][:b]}#{hashes[4][:c]} | #{hashes[5][:a]}#{hashes[5][:b]}#{hashes[5][:c]} ".center(60)
  puts " #{hashes[3][:d]}#{hashes[3][:e]}#{hashes[3][:f]} | #{hashes[4][:d]}#{hashes[4][:e]}#{hashes[4][:f]} | #{hashes[5][:d]}#{hashes[5][:e]}#{hashes[5][:f]} ".center(60)
  puts " #{hashes[3][:g]}#{hashes[3][:h]}#{hashes[3][:i]} | #{hashes[4][:g]}#{hashes[4][:h]}#{hashes[4][:i]} | #{hashes[5][:g]}#{hashes[5][:h]}#{hashes[5][:i]} ".center(60)
  puts "-----+-----+-----".center(60)
  puts " #{hashes[6][:a]}#{hashes[6][:b]}#{hashes[6][:c]} | #{hashes[7][:a]}#{hashes[7][:b]}#{hashes[7][:c]} | #{hashes[8][:a]}#{hashes[8][:b]}#{hashes[8][:c]} ".center(60)
  puts " #{hashes[6][:d]}#{hashes[6][:e]}#{hashes[6][:f]} | #{hashes[7][:d]}#{hashes[7][:e]}#{hashes[7][:f]} | #{hashes[8][:d]}#{hashes[8][:e]}#{hashes[8][:f]} ".center(60)
  puts " #{hashes[6][:g]}#{hashes[6][:h]}#{hashes[6][:i]} | #{hashes[7][:g]}#{hashes[7][:h]}#{hashes[7][:i]} | #{hashes[8][:g]}#{hashes[8][:h]}#{hashes[8][:i]} ".center(60)
  space
end

def reset_board(hashes)                     # THIS SETS AND RESETS THE BOARD WITH ALL MOVES AVAILABLE => RETURNS nil
  symbols = (:a..:i).to_a
  numbers = ('1'..'9').to_a
  hash_index = 0
  symbol_index = 0
  loops = 0
  loop do
    loop do
      if symbol_index == 4  
         hashes[hash_index][symbols[symbol_index]] = "#{numbers[hash_index]}"
      else 
        hashes[hash_index][symbols[symbol_index]] = ' '
      end
      symbol_index += 1
      break if symbol_index > 8
    end
    symbol_index = 0
    hash_index += 1
    loops += 1
    break if loops > 8
  end
end

def reset_moves(user, computer, squares)    # RESETS PLAYER AND COMPUTER MOVES TO EMPTY ARRAYS (except for indicator element) AND OPEN_SQUARES
  until user.size == 1
    user.pop
  end
  until computer.size == 1
    computer.pop
  end
  until squares.size == 0
    squares.pop
  end
  squares << ('1'..'9').to_a
  squares.flatten!
end

def check_for_win(moves)                    # THIS CHECKS IF ALL ELEMENTS OF A WINS SUB ARRAY EXIST IN PLAYER (OR COMP) MOVES => RETURNS BOOLEAN
  wins = ['123', '456', '789', '147', '258', '369', '159', '357'].map! {|x| x.chars}
  wins.any? {|sub_array| sub_array.all? {|combo| moves.include?(combo)}}
end

def check_for_tie(remaining_moves)          # input open_squares output boolean
  remaining_moves.size == 0
end

# CHANGED THIS SO ANY PLAYER CAN BE X USE THIS ONE
def input_either_player_move(active_player, remaining_moves, square_choice, hash)          # DOES THIS DO TOO MANY THINGS?
  if active_player[1] == 'X'  # a_p is u_moves OR c_moves, r_m is open_squares, s_c is USER INPUT or COMPUTER SAMPLE, hash is working hash
    hash[(square_choice.to_i) - 1][:e] = 'X'
  else
    hash[(square_choice.to_i) - 1][:e] = 'O'
  end                         
  active_player << square_choice                   
  remaining_moves.delete(square_choice)                                
end

  
def add_player(wins_hash, player_name)    # DO THIS TWICE AFTER GENERATING PLAYER NAMES
  wins_hash[player_name] = 0
end

def determine_player_order(player_one, player_two, hashes) # p_o is user_moves, p_t is computer_moves  MUST CHOOSE BEFORE EVERY GAME
  order = ''
  loop do
    system "clear"
    display_board(hashes)
    puts ''
    puts "For This Game:".center(60)
    double_space
    puts "Would You Like To Be 'X' Or 'O'?".center(60)
    double_space
    puts "Please Input 'X' or 'O'.".center(60)
    puts ''
    order = gets.chomp.downcase
    break if order == 'x'
    break if order == 'o'
    puts "Please Input Only 'X' Or 'O'.".center(60)
    sleep(1)
  end
  if order == 'x' 
    player_one << 'X'
    player_two << 'O'
  else
    player_one << 'O' 
    player_two << 'X'
  end
  system "clear"
end

def users_turn(user_moves, remaining_moves, name, hash) # input user_moves, open_squares both are mutated according to user input
  square = ''
  loop do
    display_board(hash)
    double_space
    puts "Please Choose An Available Square, #{name}.".center(60)
    puts ''
    square = gets.chomp
    if remaining_moves.include?(square)
      user_moves << square 
      remaining_moves.delete(square)
      # puts ''
      # puts ''
      puts "You Have Chosen Square Number #{square}!".center(60)
      delay_clear
      break
    else
      puts "Please Choose An Available Square".center(60)
      sleep(1)
      system 'clear'
    end
  end
  square
end

def computers_turn(computer_moves, remaining_moves, name, hash) # , hashes   input computer_moves, open squares both are mutated by sample
  # system "clear"
  display_board(hash)                     # clear, display, delay                           # returns square choice
  double_space
  puts "#{name} is choosing a square".center(60)
  # double_space
  # delay_clear
  choice = remaining_moves.sample
  computer_moves << choice
  remaining_moves.delete(choice)
  double_space
  puts "#{name} Has Chosen Square Number #{choice}!".center(60)
  # double_space
  delay_clear
  choice
end

def add_winner(wins_hash, winner)               # total_wins_hash AND user_name OR computer_name
  wins_hash[winner] += 1
end

def display_wins_words(wins_hash, player)                    # total_wins_hash  MAYBE REFORMAT SO EVERYTHING IS CENTERED
  winner = wins_hash.max_by {|_k, v| v}                   # MAYBE ADD A CONDITIONAL FOR TIES
  loser = wins_hash.min_by {|_k, v| v}                    # MAYBE USE user_win and computer_win VARIABLES
  # double_space
  if winner == loser 
    double_space
    puts "#{player.upcase} IS THE WINNER #{'!' * winner[1]}".center(60)
    double_space
    puts "Players Are Tied For Wins #{'!' * winner[1]}".center(60)
    
  else
    puts ''
    puts "#{player.upcase} IS THE WINNER #{'!' * winner[1]}".center(60) 
    puts ''
    puts "#{winner[0].upcase} IS LEADING WITH #{winner[1]} WIN#{winner[1] == 1 ? '' : 'S'} #{'!' * winner[1]}".center(60)
    puts ''
    puts "#{loser[0]} only has #{loser[1]} win#{loser[1] == 1 ? '' : 's'} #{'.' * loser[1]}".center(60)
    # double_space
  end
end

def check_for_win_index(moves)                # THIS FINDS INDEX OF WINNING COMBO => RETURNS INDEX INTEGER
  wins = ['123', '456', '789', '147', '258', '369', '159', '357'].map! {|x| x.chars}
  wins.index {|sub_array| sub_array.all? {|combo| moves.include?(combo)}}
end

def display_winning_line(hashes, moves) # USE THIS UPDATES BOARD HASH, RETURNS CASE INTEGER TRY TO MINIMIZE THE LOOPS 2 works
  symbols = (:a..:i).to_a
  character_array = ['-', '|', '\\', '/']
  # value_array_key = [starting_square, square_increment, starting_symbol_index, symbol_increment, character_array_index]
  combo = check_for_win_index(moves) 
  case combo 
  when 0
    value_array = [0,1,3,2,0]
  when 1
    value_array = [3,1,3,2,0]
  when 2
    value_array = [6,1,3,2,0]
  when 3
    value_array = [0,3,1,6,1]
  when 4
    value_array = [1,3,1,6,1]
  when 5
    value_array = [2,3,1,6,1]
  when 6
    value_array = [0,4,0,8,2]
  when 7
    value_array = [2,2,2,4,3]
  end

  3.times do
    hashes[value_array[0]][symbols[value_array[2]]] = "#{character_array[value_array[4]]}"
    hashes[value_array[0]][symbols[value_array[2] + value_array[3]]] = "#{character_array[value_array[4]]}"
    value_array[0] += value_array[1]
  end
  display_board(hashes)
end

def delay_clear
  # double_space
  double_space
  puts "Press 'Enter' To Continue".center(60)
  # double_space
  # double_space
  gets.chomp
  system "clear"
end

def choose_opponent(name_choice, name_array) # USES LOOP  (computer_name, computer_names_array)
  loop do
    name_choice.delete!(name_choice[0])
    break if name_choice.length == 0
  end
  name_choice << name_array.sample
end

def choose_opponent(name_choice, name_array)  # USES UNLESS  (computer_name, computer_names_array)
  until name_choice.length == 0
    name_choice.delete!(name_choice[0])
  end
  name_choice << name_array.sample
end

def computer_or_second_player  # => RETURNS 'player' or 'computer' STRING
  system 'clear'
  answer = ''
  loop do
    double_space
    puts 'Would You Like To Play The Computer'.center(60)
    double_space
    puts 'Or Another Player?'.center(60)
    puts ''
    answer = gets.chomp.downcase
    break if answer.start_with?(/(a|c|p){1}/)
    # break if answer.start_with?('c')
    puts "Please Enter 'Computer' Or 'Player'.".center(60)
    sleep(1)
    system 'clear'
  end
  answer.start_with?(/(a|p){1}/) ? 'player' : 'computer'
end

def choose_opponent(name_choice, name_array)  # USES REPLACE  USE THIS ONE # RENAME THIS TO name_opponent
  name_choice.replace(name_array.sample)
end

def choose_opponent_dialog(name_choice, name_array)   # (computer_name, computer_names_array)
  loop do
    choose_opponent(name_choice, name_array)
    # computer_name = computer_names_array.sample
    answer = ''
    loop do
      system 'clear'
      double_space
      puts "You Will Be Playing With #{name_choice}.".center(60)
      double_space
      puts 'Is That OK, Or Would You Like To Play Another Opponent? (Y/N)'.center(60)
      puts ''
      answer = gets.chomp.downcase
      break if answer.start_with?('y')
      if answer.start_with?('n')
        puts ''
        puts "Let's Choose Again.".center(60)
        sleep(1)
        choose_opponent(name_choice, name_array)
      else
        puts ''
        puts "Please Enter 'Yes' Or 'No'.".center(60)
        sleep(1)
      end
    end
    break if answer.start_with?('y')
  end
  puts '' 
  puts " GREAT! LET'S GET STARTED!".center(60)
end

def choose_either_opponent_dialog(name_choice, name_array)   # (computer_name, computer_names_array)
  choice = computer_or_second_player
  if choice == 'player'
    system 'clear'
    double_space
    puts "What Is The Second Player's Name?".center(60)
    puts ''
    name_choice.replace(gets.chomp.capitalize)
  else
    loop do
      choose_opponent(name_choice, name_array)
      # computer_name = computer_names_array.sample
      answer = ''
      loop do
        system 'clear'
        double_space
        puts "You Will Be Playing With #{name_choice}.".center(60)
        double_space
        puts 'Is That OK, Or Would You Like To Play Another Opponent? (Y/N)'.center(60)
        puts ''
        answer = gets.chomp.downcase
        break if answer.start_with?('y')
        if answer.start_with?('n')
          puts ''
          puts "Let's Choose Again.".center(60)
          sleep(1)
          choose_opponent(name_choice, name_array)
        else
          puts ''
          puts "Please Enter 'Yes' Or 'No'.".center(60)
          sleep(1)
        end
      end
      break if answer.start_with?('y')
    end
  end
  puts '' 
  puts " GREAT! LET'S GET STARTED!".center(60)
end

def choose_user(name_choice)  # (user_name)
  name_choice.replace(gets.chomp.capitalize)  
end

def board_animation               # LONGHAND
  board_hash = set_board() # BACK TO BLANKS FOR LINES
  reset_board(board_hash)
  display_board(board_hash)
  double_space
  puts "Choose 3 Squares In A Row To Win".center(60)
  sleep(2)
  reset_board(board_hash)
  display_winning_line(board_hash, ['1','2','3'])
  double_space
  puts "Choose 3 Squares In A Row To Win".center(60)
  double_space
  puts "Horizontally".center(60)
  sleep(2)
  reset_board(board_hash)
  display_winning_line(board_hash, ['4','5','6'])
  double_space
  puts "Choose 3 Squares In A Row To Win".center(60)
  double_space
  puts "Horizontally".center(60)
  sleep(2)
  reset_board(board_hash)
  display_winning_line(board_hash, ['7','8','9'])
  double_space
  puts "Choose 3 Squares In A Row To Win".center(60)
  double_space
  puts "Horizontally".center(60)
  sleep(2)
  reset_board(board_hash)
  display_winning_line(board_hash, ['1','4','7'])
  double_space
  puts "Choose 3 Squares In A Row To Win".center(60)
  double_space
  puts "Vertically".center(60)
  sleep(2)
  reset_board(board_hash)
  display_winning_line(board_hash, ['2','5','8'])
  double_space
  puts "Choose 3 Squares In A Row To Win".center(60)
  double_space
  puts "Vertically".center(60)
  sleep(2)
  reset_board(board_hash)
  display_winning_line(board_hash, ['3','6','9'])
  double_space
  puts "Choose 3 Squares In A Row To Win".center(60)
  double_space
  puts "Vertically".center(60)
  sleep(2)
  reset_board(board_hash)
  display_winning_line(board_hash, ['1','5','9'])
  double_space
  puts "Choose 3 Squares In A Row To Win".center(60)
  double_space
  puts "Diagonally".center(60)
  sleep(2)
  reset_board(board_hash)
  display_winning_line(board_hash, ['3','5','7'])
  double_space
  puts "Choose 3 Squares In A Row To Win".center(60)
  double_space
  puts "Diagonally".center(60)
  sleep(2)
  reset_board(board_hash)
end

def board_animation(wins)     #(winning_groups)  # USE THIS ONE
  words = ['Horizontally', 'Horizontally', 'Horizontally',
           'Vertically', 'Vertically', 'Vertically', 
           'Diagonally', 'Diagonally']
  board_hash = set_board() # BACK TO BLANKS FOR LINES
  num = 0
  reset_board(board_hash)
  display_board(board_hash)

  wins.each do |moves|
    reset_board(board_hash)
    display_winning_line(board_hash, moves)
    double_space
    puts "Choose 3 Squares In A Row To Win".center(60)
    double_space
    puts "#{words[num]}".center(60)
    num += 1
    sleep(1)
  end
end

# THIS SHOULD NOT BE A METHOD. JUST USE CODE
# def greet_player(computer_name_array, user, computer) # input computer_names array, user_name, computer_name mutates both names
system 'clear'
board_hash = set_board()
loop do
  double_space
  puts "HELLO!".center(60)
  double_space
  puts "What Is Your Name?".center(60)
  choose_user(user_name)
  break if user_name.length > 0
  if user_name.length == 0
    puts ''
    puts " Please Enter Your Name.".center(60)
    sleep(1)
  end
  system 'clear'
end
system 'clear'
double_space
puts "Hi #{user_name}!".center(60)
double_space
puts "Let's Play Some Tic-Tac_Toe.".center(60)
delay_clear
system "clear"

instructions = ''
loop do
  double_space
  puts "Do You Want To Know How To Play?".center(60)
  puts ''
  instructions = gets.chomp.downcase
  break if instructions.start_with?('y')
  break if instructions.start_with?('n')
  puts "Please Input 'Yes' Or 'No'.".center(60)
  sleep(1)
  system 'clear'
end
loop do
  system 'clear'
  break if instructions.start_with?('n')
  double_space
  puts "You Will First Choose An Opponent.".center(60)
  double_space
  puts "You Will Then Choose 'X' Or 'O'.".center(60)
  double_space
  puts "'X' Will Go First.".center(60)
  delay_clear

  display_board(board_hash)    # DISPLAYS BLANK BOARD
  puts ''
  puts ''
  puts "This Is Where You Will Play".center(60)
  delay_clear() # MAKE THIS INTO AN AUTOMATED PROGRESSION? OR WAIT TILL LINES PART?
  
  reset_board(board_hash)      # RESETS ALL SQUARES TO NUMBERS 
  display_board(board_hash)    # DISPLAYS BLANK BOARD
  puts ''
  puts ''
  puts "You Can Choose Any Numbered Square".center(60)
  delay_clear()
  again = ''
  board_animation(winning_groups)
  system "clear"
  loop do
    
    loop do
      double_space
      puts "Do You Want To Learn Again?".center(60)
      puts ''
      again = gets.chomp.downcase
      break if again.start_with?('n')
      break if again.start_with?('y')
      puts "Please Enter 'Yes' Or 'No'.".center(60)
      sleep(1)
      system 'clear'
    end
    break if again.start_with?('y')
    break if again.start_with?('n')
  end
  break if again.start_with?('n')
  board_hash = set_board()
end

system "clear"
double_space
puts "Let's Choose An Opponent For Some TIC-TAC-TOE!".center(60)
# double_space
delay_clear
choose_either_opponent_dialog(computer_name, computer_names_array)

add_player(total_wins_hash, user_name)    # DO THIS TWICE AFTER GENERATING PLAYER NAMES
add_player(total_wins_hash, computer_name)    # DO THIS TWICE AFTER GENERATING PLAYER NAMES

board_hash = set_board

display_board(board_hash)    # DISPLAYS BLANK BOARD
double_space
puts "Let's Play!".center(60)
delay_clear

reset_board(board_hash)      # RESETS ALL SQUARES TO NUMBERS
display_board(board_hash) 
puts '' # NEED THESE PUTS ?
puts ''
# HERE WE HAVE TO DETERMINE WHO IS PLAYING AS X AND START A LOOP WITH WHOEVER IS PLAYER 1 GOING FIRST
loop do
  determine_player_order(user_moves, computer_moves, board_hash) # p_o is user_moves, p_t is computer_moves  MUST CHOOSE BEFORE EVERY GAME
  if user_moves[1] == 'X'
    starting_player = 1
  else
    starting_player = 0
  end
  loop do  # THIS IS GAME PLAY LOOP
    # system "clear"
    if starting_player == 1    
      # display_board(board_hash)       # PROBABLY REORDER THIS SO BOARD IS FIRST WITH WORDS UNDERNEATH  ADD WAY TO DETERMINE WINNER NAME
      user_choice = users_turn(user_moves, open_squares, user_name, board_hash)
      input_either_player_move(user_moves, open_squares, user_choice, board_hash)
      user_win = check_for_win(user_moves)                    # THIS CHECKS IF ALL ELEMENTS OF A WINS SUB ARRAY EXIST IN PLAYER (OR COMP) MOVES => RETURNS BOOLEAN
      # system "clear"
      display_board(board_hash)
      starting_player -= 1
      # delay_clear()
        break if user_win
        break if open_squares.size == 0
    else 
      # display_board(board_hash)
      if computer_names_array.any?(computer_name)
        computer_choice = computers_turn(computer_moves, open_squares, computer_name, board_hash)
      else
        computer_choice = users_turn(computer_moves, open_squares, computer_name, board_hash)
      end
      input_either_player_move(computer_moves, open_squares, computer_choice, board_hash)
      computer_win = check_for_win(computer_moves)
      # system "clear"
      display_board(board_hash)
      starting_player += 1
      # delay_clear()
        break if computer_win
        break if open_squares.size == 0
    end
    #sleep(2)
  end
  system "clear"

  if user_win
    system "clear"
    add_winner(total_wins_hash, user_name)               # total_wins_hash AND user_name OR computer_name
    display_winning_line(board_hash, user_moves)
    display_wins_words(total_wins_hash, user_name)
  elsif computer_win
    system "clear"
    add_winner(total_wins_hash, computer_name)               # total_wins_hash AND user_name OR computer_name
    display_winning_line(board_hash, computer_moves)
    display_wins_words(total_wins_hash, computer_name)
  else 
    system "clear"
    double_space
    double_space
    puts 'X = O = X = O = X'.center(60)
    puts ''
    puts 'O = X  TIE  X = O'.center(60)
    puts ''
    puts 'X = O = X = O = X'.center(60)
    puts ''
    puts 'PLEASE PLAY AGAIN'.center(60)
    double_space
    double_space
  end
  delay_clear
  again = ''
  loop do
    system 'clear'
    double_space
    puts "Would You Like To Play Again?".center(60)
    puts ''
    again = gets.chomp.downcase
    break if again.start_with?(/(y|n){1}/)
    # break if again.start_with?('n')
    puts "Please Type 'Yes' If You Want To Play Again.".center(60)
    double_space
    puts "'No' If You Do Not.".center(60)
    sleep(1.5)
    # system 'clear'
  end
  break if again.start_with?('n')
  reset_board(board_hash)
  reset_moves(user_moves, computer_moves, open_squares)
end
system "clear"
double_space
puts "THANK YOU FOR PLAYING !".center(60)
double_space
champion = total_wins_hash.max_by {|_k, v| v}
hash_values = total_wins_hash.values
if hash_values[0] == hash_values[1]
  puts "YOU ARE BOTH TIED #{'!' * champion[1]}".center(60)
elsif champion[0] == user_name
  puts "YOU ARE THE WINNER, #{user_name.upcase} #{'!' * champion[1]}".center(60)
else
  puts "#{champion[0].upcase} IS THE WINNER #{'!' * champion[1]}".center(60)
end
double_space
puts "GOODBYE !".center(60)
# double_space
delay_clear()
system "clear"

