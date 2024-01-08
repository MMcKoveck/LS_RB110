###################################
######      SAME AS # 5      ######
######      EDIT    AND      ######
######        DISSECT        ######
######        METHODS        ######
###################################

                         # BEGINNING VALUES
winning_groups = ['123', '456', '789', '147', '258', '369', '159', '357']
winning_groups.map!(&:chars)
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
                            # METHODS
# INPUT : none
# OUTPUT :  one line
# RETURN : nil
# MUTATES : n
def space
  puts ''
end

# INPUT :  none
# OUTPUT :  two lines
# RETURN : nil
# MUTATES : n
def double_space
  puts ''
  puts ''
end

# INPUT :  none
# OUTPUT :  none
# RETURN : hash_array(value of), used
# MUTATES : y
def set_board
  symbols = (:a..:i).to_a
  blanks = Hash.new(' ')
  hash_array = []
  9.times do
    hash_array << symbols.zip(symbols.map { |sym| blanks[sym] }).to_h
  end
  hash_array
end

# INPUT : board hash
# OUTPUT :input hash on board
# RETURN : nil
# MUTATES : y
def display_board(hashes)
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

# INPUT :  board hash
# OUTPUT :  none
# RETURN : nil
# MUTATES : y
def reset_board(hashes)
  symbols = (:a..:i).to_a
  numbers = ('1'..'9').to_a
  hash_index = 0
  symbol_index = 0
  loops = 0
  loop do
    loop do
      if symbol_index == 4
        hashes[hash_index][symbols[symbol_index]] = numbers[hash_index].to_s
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

# INPUT: moves, squares
# OUTPUT:none
# RETURN: full square array, not used
# MUTATES: y
def reset_moves(user, computer, squares)
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

# INPUT : moves
# OUTPUT :  none
# RETURN : boolean, used
# MUTATES : n
def check_for_win(moves)
  wins = ['123', '456', '789', '147', '258', '369', '159', '357'].map!(&:chars)
  wins.any? { |sub_array| sub_array.all? { |combo| moves.include?(combo) } }
end

# INPUT :  moves, open_squares, choice, board_hash
# OUTPUT : none
# RETURN : choice string, not used
# MUTATES : y
def input_either_player_move(active_player, remaining_moves, square_choice, hash)
  if active_player[1] == 'X'
    hash[(square_choice.to_i) - 1][:e] = 'X'
  else
    hash[(square_choice.to_i) - 1][:e] = 'O'
  end
  active_player << square_choice
  remaining_moves.delete(square_choice)
end

# INPUT : wins_hash, name string
# OUTPUT : none
# RETURN : 0, not used
# MUTATES : y
def add_player(wins_hash, player_name)
  wins_hash[player_name] = 0
end

# INPUT: players, board_hash
# OUTPUT: strings
# RETURN: boolean, not used
# MUTATES : y
def determine_player_order(player_one, player_two, hashes)
  order = ''
  loop do
    system "clear"
    display_board(hashes)
    space
    puts "For This Game:".center(60)
    double_space
    puts "Would You Like To Be 'X' Or 'O'?".center(60)
    space
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

# INPUT : moves, open_squares, user_name, board_hash
# OUTPUT : strings
# RETURN : choice string, used
# MUTATES : y
def users_turn(user_moves, remaining_moves, name, hash)
  square = ''
  loop do
    display_board(hash)
    double_space
    puts "Please Choose An Available Square, #{name}.".center(60)
    space
    square = gets.chomp
    if remaining_moves.include?(square)
      user_moves << square
      remaining_moves.delete(square)
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

# INPUT : moves, open_squares
# OUTPUT : strings
# RETURN : choice string, used
# MUTATES : y
def computers_turn(computer_moves, remaining_moves, name, hash)
  display_board(hash)
  double_space
  puts "#{name} is choosing a square".center(60)
  choice = remaining_moves.sample
  computer_moves << choice
  remaining_moves.delete(choice)
  double_space
  puts "#{name} Has Chosen Square Number #{choice}!".center(60)
  delay_clear
  choice
end

# INPUT : wins_hash, player_name
# OUTPUT : none
# RETURN : 1, not used
# MUTATES : y
def add_winner(wins_hash, winner)
  wins_hash[winner] += 1
end

# INPUT : wins_hash, player_name
# OUTPUT : strings
# RETURN : nil
# MUTATES : n
def display_wins_words(wins_hash, player)
  winner = wins_hash.max_by { |_k, v| v }
  loser = wins_hash.min_by { |_k, v| v }
  if winner == loser
    double_space
    puts "#{player.upcase} IS THE WINNER #{'!' * winner[1]}".center(60)
    double_space
    puts "Players Are Tied For Wins #{'!' * winner[1]}".center(60)
  else
    space
    puts "#{player.upcase} IS THE WINNER #{'!' * winner[1]}".center(60)
    space
    puts "#{winner[0].upcase} IS LEADING WITH #{winner[1]} WIN#{winner[1] == 1 ? '' : 'S'} #{'!' * winner[1]}".center(60)
    space
    puts "#{loser[0]} has #{loser[1]} win#{loser[1] == 1 ? '' : 's'} #{'.' * loser[1]}".center(60)
  end
end

# INPUT : moves
# OUTPUT : none
# RETURN : boolean, used
# MUTATES : n
def check_for_win_index(moves)
  wins = ['123', '456', '789', '147', '258', '369', '159', '357'].map!(&:chars)
  wins.index { |sub_array| sub_array.all? { |combo| moves.include?(combo) } }
end

# INPUT : board_hash, moves
# OUTPUT :  lined board
# RETURN : nil
# MUTATES : y
def display_winning_line(hashes, moves)
  symbols = (:a..:i).to_a
  character_array = ['-', '|', '\\', '/']
  # value_array KEY = [starting_square, square_increment, starting_symbol_index,
  #                    symbol_increment, character_array_index]
  combo = check_for_win_index(moves)
  case combo
  when 0
    value_array = [0, 1, 3, 2, 0]
  when 1
    value_array = [3, 1, 3, 2, 0]
  when 2
    value_array = [6, 1, 3, 2, 0]
  when 3
    value_array = [0, 3, 1, 6, 1]
  when 4
    value_array = [1, 3, 1, 6, 1]
  when 5
    value_array = [2, 3, 1, 6, 1]
  when 6
    value_array = [0, 4, 0, 8, 2]
  when 7
    value_array = [2, 2, 2, 4, 3]
  end

  3.times do
    hashes[value_array[0]][symbols[value_array[2]]] = character_array[value_array[4]].to_s
    hashes[value_array[0]][symbols[value_array[2] + value_array[3]]] = character_array[value_array[4]].to_s
    value_array[0] += value_array[1]
  end
  display_board(hashes)
end

# INPUT :  none
# OUTPUT :  strings
# RETURN : true, not used
# MUTATES : n
def delay_clear
  double_space
  puts "Press 'Enter' To Continue".center(60)
  gets.chomp
  system "clear"
end

# INPUT : computer_name, name array
# OUTPUT :  name choice
# RETURN : chosen name, not used
# MUTATES : y
def choose_opponent(name_choice, name_array)
  name_choice.replace(name_array.sample)
end

# INPUT : user_name
# OUTPUT : none
# RETURN : input string, not used
# MUTATES : y
def choose_user(name_choice)
  name_choice.replace(gets.chomp.capitalize)
end

# INPUT : none
# OUTPUT : strings
# RETURN : true
# MUTATES : n
def tie_dialog_one
  double_space
  double_space
  puts 'X = O = X = O = X'.center(60)
  space
  puts 'O = X  TIE  X = O'.center(60)
  space
  puts 'X = O = X = O = X'.center(60)
  space
  puts 'NO  AWARDED  WINS'.center(60)
  double_space
  double_space
  sleep(0.75)
  system 'clear'
end

# INPUT : none
# OUTPUT : strings
# RETURN : true
# MUTATES : n
def tie_dialog_two
  double_space
  double_space
  puts 'O = X = O = X = O'.center(60)
  space
  puts 'X = O  TIE  O = X'.center(60)
  space
  puts 'O = X = O = X = O'.center(60)
  space
  puts 'PLEASE PLAY AGAIN'.center(60)
  double_space
  double_space
  sleep(0.75)
  system 'clear'
end

# INPUT : none
# OUTPUT : strings animation
# RETURN : wins_array value
# MUTATES : n
def board_animation
  words = ['Horizontally', 'Horizontally', 'Horizontally',
           'Vertically', 'Vertically', 'Vertically',
           'Diagonally', 'Diagonally']
  board_hash = set_board
  wins = ['123', '456', '789', '147', '258', '369', '159', '357'].map!(&:chars)
  num = 0
  reset_board(board_hash)
  display_board(board_hash)
  wins.each do |moves|
    reset_board(board_hash)
    display_winning_line(board_hash, moves)
    double_space
    puts "Choose 3 Squares In A Row To Win".center(60)
    double_space
    puts words[num].to_s.center(60)
    num += 1
    sleep(1)
  end
end

# BEGIN GAME
system 'clear'
board_hash = set_board
loop do
  double_space
  puts "HELLO!".center(60)
  double_space
  puts "What Is Your Name?".center(60)
  choose_user(user_name)
  break if user_name.length > 0
  if user_name.length == 0
    space
    puts " Please Enter Your Name.".center(60)
    sleep(1)
  end
  system 'clear'
end
system 'clear'
double_space
puts "Hi #{user_name}!".center(60)
double_space
puts "Let's Play Some Tic-Tac-Toe.".center(60)
delay_clear
system "clear"

# OPTIONAL INSTRUCTIONS
instructions = ''
loop do
  double_space
  puts "Do You Want To Know How To Play?".center(60)
  space
  instructions = gets.chomp.downcase
  break if instructions.start_with?(/(y|n){1}/)
  puts "Please Input 'Yes' Or 'No'.".center(60)
  sleep(1)
  system 'clear'
end

# INSTRUCTION LOOP
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
  display_board(board_hash)
  double_space
  puts "This Is Where You Will Play".center(60)
  delay_clear
  reset_board(board_hash)
  display_board(board_hash)
  double_space
  puts "You Can Choose Any Numbered Square".center(60)
  delay_clear
  again = ''
  board_animation # LONG METHOD
  system "clear"
  loop do
    double_space
    puts "Do You Want To Learn Again?".center(60)
    space
    again = gets.chomp.downcase
    break if again.start_with?(/(n|y){1}/)
    puts "Please Enter 'Yes' Or 'No'.".center(60)
    sleep(1)
    system 'clear'
  end
  break if again.start_with?('n')
  board_hash = set_board
end

# START BY CHOOSING OPPONENT
system "clear"
double_space
puts "Let's Choose An Opponent For Some TIC-TAC-TOE!".center(60)
delay_clear

answer = ''
loop do
  double_space
  puts 'Would You Like To Play The Computer'.center(60)
  double_space
  puts 'Or Another Player?'.center(60)
  answer = gets.chomp.downcase
  break if answer.start_with?(/(a|p|c){1}/)
  puts "Please Enter 'Computer' Or 'Player'.".center(60)
  sleep(1)
  system 'clear'
end
answer = answer.start_with?(/(a|p){1}/) ? 'player' : 'computer'
if answer == 'player'
  system 'clear'
  double_space
  loop do
    puts "What Is The Second Player's Name?".center(60)
    space
    computer_name.replace(gets.chomp.capitalize)
    break if computer_name.size > 0
    puts "Please Enter A Name For Player 2.".center(60)
    sleep(1)
    system 'clear'
    double_space
  end
else
  loop do
    choose_opponent(computer_name, computer_names_array)
    answer = ''
    loop do
      system 'clear'
      double_space
      puts "You Will Be Playing With #{computer_name}.".center(60)
      double_space
      puts 'Is That OK, Or Would You Like To Play Another Opponent? (Y/N)'.center(60)
      space
      answer = gets.chomp.downcase
      break if answer.start_with?('y')
      space
      if answer.start_with?('n')
        puts "Let's Choose Again.".center(60)
        sleep(1)
        choose_opponent(computer_name, computer_names_array)
      else
        puts "Please Enter 'Yes' Or 'No'.".center(60)
        sleep(1)
      end
    end
    break if answer.start_with?('y')
  end
end
system 'clear'
double_space
puts "It'll be #{user_name} Vs. #{computer_name}!".center(60)
double_space
puts "GOOD LUCK!".center(60)
delay_clear

add_player(total_wins_hash, user_name)
add_player(total_wins_hash, computer_name)

board_hash = set_board

# GET READY TO PLAY
display_board(board_hash)
space
puts "Let's Play!".center(60)
delay_clear

reset_board(board_hash)
display_board(board_hash)
double_space

# MAIN GAME LOOP
loop do
  determine_player_order(user_moves, computer_moves, board_hash)
  if user_moves[1] == 'X'
    starting_player = 1
  else
    starting_player = 0
  end

  # ACTUAL GAME PLAY
  loop do
    if starting_player == 1
      user_choice = users_turn(user_moves, open_squares, user_name, board_hash)
      input_either_player_move(user_moves, open_squares, user_choice, board_hash)
      user_win = check_for_win(user_moves)
      display_board(board_hash)
      starting_player -= 1
      break if user_win || open_squares.size == 0
    # PLAYER 2 IS COMPUTER OR LIVING PLAYER
    else
      if computer_names_array.any?(computer_name)
        computer_choice = computers_turn(computer_moves, open_squares, computer_name, board_hash)
      else
        computer_choice = users_turn(computer_moves, open_squares, computer_name, board_hash)
      end
      input_either_player_move(computer_moves, open_squares, computer_choice, board_hash)
      computer_win = check_for_win(computer_moves)
      display_board(board_hash)
      starting_player += 1
      break if computer_win || open_squares.size == 0
    end
  end

  system "clear"
  # AFTER GAME ENDS
  if user_win
    add_winner(total_wins_hash, user_name)
    display_winning_line(board_hash, user_moves)
    display_wins_words(total_wins_hash, user_name)
  elsif computer_win
    add_winner(total_wins_hash, computer_name)
    display_winning_line(board_hash, computer_moves)
    display_wins_words(total_wins_hash, computer_name)
  else
    tie_dialog_two
    tie_dialog_one
    tie_dialog_two
    tie_dialog_one
    tie_dialog_two
  end
  delay_clear
  again = ''

  # PLAY AGAIN ?
  loop do
    system 'clear'
    double_space
    puts "Would You Like To Play Again?".center(60)
    space
    again = gets.chomp.downcase
    break if again.start_with?(/(y|n){1}/)
    puts "Please Type 'Yes' If You Want To Play Again.".center(60)
    double_space
    puts "'No' If You Do Not.".center(60)
    sleep(1.5)
  end

  break if again.start_with?('n')
  reset_board(board_hash)
  reset_moves(user_moves, computer_moves, open_squares)
end

# OUTRO
system "clear"
double_space
puts "THANK YOU FOR PLAYING !".center(60)
double_space
champion = total_wins_hash.max_by { |_k, v| v }
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
delay_clear
system "clear"
