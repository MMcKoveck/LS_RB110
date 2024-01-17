####################################
####################################
#      ALL THE FUNCTIONALITY OF 3
#        
# NEEDS TO BE REFACTORED FOR RUBOCOP
#         MAYBE CONDENSE ENDS
####################################
####################################

# INPUT : none
# OUTPUT : one blank line
# RETURN : nil
# MUTATES : no
def single
  puts ''
end

# INPUT : none
# OUTPUT : two blank lines
# RETURN : nil
# MUTATES : no
def double
  puts ''
  puts ''
end

# INPUT : player_hand OR dealer_hand array of sub arrays
# OUTPUT : none
# RETURN : boolean
# MUTATES : no
def busted?(hand)
  total_score(hand) > 21
end

# INPUT : dealer_hand array of sub arrays
# OUTPUT : none
# RETURN : boolean
# MUTATES : no
def dealer_hit_again?(hand)
  total_score(hand) < 17
end

# INPUT : player_hand AND dealer_hand array of sub arrays
# OUTPUT : none
# RETURN : string elements that guide play
# MUTATES : no
def player_hit_or_stay?(player, dealer)
  player_score = total_score(player)
  values = card_values([dealer[0]])
  convert_cards!(values)
  aces = count_aces(values)
  extract_aces!(values)
  dealer_shows = add_all_cards(values, aces)
  if (player_score == 12 && (dealer_shows > 3 && dealer_shows < 7)) ||
     ((player_score > 12 && player_score < 17) && dealer_shows < 7) ||
     (player_score > 16)
    'HIT OR STAY'
  else
    'STAY OR HIT'
  end
end

# INPUT : player_hand OR dealer_hand array of sub arrays
# OUTPUT : none
# RETURN : boolean
# MUTATES : no
def winner?(hand)
  total_score(hand) == 21
end

# INPUT : deck
# OUTPUT : none
# RETURN : new, randomized deck array of 2 element sub arrays
# MUTATES : any array becomes a new randomized deck array
deck = []
def reset_deck!(new_deck)
  suit_letters = ['S', 'C', 'D', 'H']
  counter = 0
  new_deck.clear
  new_suit = []
  4.times do
    new_suit << ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
    new_suit.map! { |x| x.map { |y| [y] << suit_letters[counter] } }
    new_deck << new_suit
    new_suit = []
    counter += 1
  end
  new_deck.flatten!(2).shuffle!
end

# INPUT : deck, player_hand, dealer_hand
# OUTPUT : none
# RETURN : 2 (not used)
# MUTATES : deck, player_hand, dealer_hand
def deal_cards!(deck, player, dealer)
  2.times do
    player << deck.shift
    dealer << deck.shift
  end
end

# INPUT : deck
# OUTPUT : shuffle dialog
# RETURN : nil
# MUTATES : yes deck
def shuffle_dialog!(deck, player_wins, dealer_wins)
  system 'clear'
  3.times { double }
  puts '=' * 50
  reset_deck!(deck)
  puts "SHUFFLING CARDS".center(50)
  puts "BEST OF LUCK!".center(50)
  puts '=' * 50
  if player_wins > 0 || dealer_wins > 0
    double
    puts '=' * 50
    puts "DEALER HAS #{dealer_wins} WINS.".center(50)
    puts "PLAYER HAS #{player_wins} WINS.".center(50)
    puts '=' * 50
  end
  sleep(2)
end

# INPUT : player_hand OR dealer_hand, deck
# OUTPUT : none
# RETURN : 2 element array of draw (not used)
# MUTATES : input array (hand) and deck
def hit!(hand, deck)
  hand << deck.shift
end

# INPUT : player_hand, dealer_hand (arrays)
# OUTPUT : none
# RETURN : empty array
# MUTATES : both input arrays are emptied
def reset_hands!(player, dealer) # RETURNS EMPTY ARRAY
  player.clear
  dealer.clear
end

# INPUT : player_hand OR dealer_hand, Integer starting with 0
# OUTPUT : none
# RETURN : Interpolated string w/ card and suit WORDS
# MUTATES : no
def show_card_words(hand, card)
  "#{CARD_VALUES[hand[card][0]]} OF #{SUIT_WORDS[hand[card][1]]}"
end

# INPUT : player_hand OR dealer_hand, Integer starting with 0
# OUTPUT : none
# RETURN : Interpolated string w/ card and suit SYMBOLS
# MUTATES : no
def show_card_sym(hand, card)
  if hand[card][0] == '10'
    "X #{SUIT_CHARS[hand[card][1]]}"
  else
    "#{hand[card][0]} #{SUIT_CHARS[hand[card][1]]}"
  end
end

# INPUT : player_hand OR dealer_hand array of sub arrays
# OUTPUT : none
# RETURN : integers showing total score of hand
# MUTATES : no
def total_score(hand)
  values = card_values(hand)
  convert_cards!(values)
  aces = count_aces(values)
  extract_aces!(values)
  add_all_cards(values, aces)
end

# INPUT : single level array of converted card values, integer number of Aces
# OUTPUT : none
# RETURN : integer total of all cards, including variably valued aces
# MUTATES : no
def add_all_cards(flat_hand, ace_count)
  total = flat_hand.sum
  case ace_count
  when 0
    total
  when 1
    total + 11 <= 21 ? total += 11 : total += 1
  when 2
    total + 12 <= 21 ? total += 12 : total += 2
  when 3
    total + 13 <= 21 ? total += 13 : total += 3
  when 4
    total + 14 <= 21 ? total += 14 : total += 4
  end
end

# INPUT : single level array of unconverted card values
# OUTPUT : none
# RETURN : mutated array
# MUTATES : yes, single level array of converted card values. integers and 'A's
def convert_cards!(array)
  array.map! do |card|
    if card =~ /(J|Q|K){1}/
      10
    elsif card =~ /(A)/
      'A'
    else
      card.to_i
    end
  end
end

# INPUT : player_hand or dealer_hand array of sub arrays
# OUTPUT : none
# RETURN : single level array of unconverted card values
# MUTATES : no
def card_values(hand)
  hand.map { |card| card[0] }
end

# INPUT : single level array of converted card values. integers and 'A's
# OUTPUT : none
# RETURN : single level array of converted card values. integers ONLY
# MUTATES : no
def extract_aces(array)
  array.reject { |card| card == 'A' }
end

# INPUT : single level array of converted card values. integers and 'A's
# OUTPUT : none
# RETURN : single level array of converted card values. integers ONLY
# MUTATES : yes, removes 'A's from array
def extract_aces!(array)
  array.reject! { |card| card == 'A' }
end

# INPUT : single level array of converted card values. integers and 'A's
# OUTPUT : none
# RETURN : integer number of Aces # save this for further use, must update
# MUTATES : no
def count_aces(array)
  aces = array.select { |card| card == 'A' }
  aces.count
end

# INPUT : none
# OUTPUT : string of 50 '='
# RETURN : nil
# MUTATES : no
def stars
  puts '=' * 50
end

# INPUT : string array
# OUTPUT : string tutorial animation
# RETURN : integer 5, not used
# MUTATES : no
def tutorial(array)
  counter = 0
  system 'clear'
  5.times do
    4.times do
      stars
      2.times do
        puts array[counter].center(50)
        counter += 1
      end
      stars
      sleep(1.5)
    end
    stars
    puts array[counter]
    stars
    counter += 1
    gets
    system 'clear'
  end
end

# INPUT : none
# OUTPUT : exit page
# RETURN : true
# MUTATES : no
def quit_game
  system 'clear'
  3.times { double }
  puts '=' * 50
  puts 'SEE! IT WORKS!'.center(50)
  puts "UNTIL NEXT TIME!".center(50)
  puts '=' * 50
  sleep(2)
  system 'clear'
end

###############################################


###############################################
tutorial_array = [
"THIS GAME IS CALLED 21.",
"THERE ARE 52 CARDS IN THE DECK.",

"AT THE BEGINNING OF EACH GAME,",
"THE DECK IS SHUFFLED ONCE.",

"EACH GAME CONSISTS OF A VARYING NUMBER OF HANDS.",
"YOU MAY PLAY AS MANY HANDS AS YOU LIKE.",

"THE HAND WINS WILL BE DISPLAYED CONTINUOUSLY,",
"AS WILL THE REMAINING NUMBER OF CARDS.",

"         PRESS ENTER TO ADVANCE TUTORIAL     (1/5)",

"THE DECK WILL BE RESHUFFLED WHEN CARDS RUN LOW.",
"BOTH YOU AND THE DEALER WILL BE GIVEN TWO CARDS.",

"YOU WILL SEE BOTH OF YOUR CARDS,",
"BUT ONLY ONE OF THE DEALER'S CARDS WILL BE SHOWN.",

"THE OBJECT OF THE GAME IS:",
"TO GET AS CLOSE TO 21 AS POSSIBLE,",

"WITHOUT GOING OVER OR 'BUSTING'.",
"CARDS ARE WORTH THEIR DISPLAYED VALUE.",

"         PRESS ENTER TO ADVANCE TUTORIAL     (2/5)",

"FACE CARDS ARE ALL WORTH 10.",
"THE ACE IS WORTH EITHER 1 OR 11.",

"A 'SOFT' HAND HAS AN ACE,",
"WHICH MAKES THE SCORE VARIABLE.",

"A 'HARD' HAND HAS NO ACES,",
"SO THE SCORE IS THE SCORE.",

"THAT IS RELEVANT TO THE PLAYER'S DECISION,",
"BUT IS NOT RELEVANT TO THE DEALER'S DECISION.",

"         PRESS ENTER TO ADVANCE TUTORIAL     (3/5)",

"IF THE DEALER HAS A NATURALLY DEALT 21,",
"THEY WILL AUTOMATICALLY WIN.",

"UNLESS YOU ALSO HAVE A NATURALLY DEALT 21,",
"IN WHICH CASE, YOU TIE, OR 'PUSH'.",

"WHEN IT IS YOUR TURN, YOU MUST EITHER:",
"CHOOSE TO RECEIVE ANOTHER CARD BY 'HITTING',",

"OR CHOOSE TO 'STAY' WITH THE CARDS YOU HAVE.",
"YOUR TURN ENDS BY 'STAYING' OR 'BUSTING'.",

"         PRESS ENTER TO ADVANCE TUTORIAL     (4/5)",

"AFTER YOUR TURN HAS BEEN COMPLETED,",
"IT BECOMES THE DEALER'S TURN.",

"YOU WILL THEN SEE THEIR 'HOLE CARD',",
"AND THEIR PLAY BEGINS.",

"THE DEALER WILL HIT UNTIL IT REACHES AT LEAST 17.",
"IT DOES NOT MATTER IF THE HAND IS HARD OR SOFT,",

"IF NEITHER PLAYER BUSTS,",
"WHOEVER HAS THE HIGHEST SCORE, WINS THE HAND.",

"           PRESS ENTER TO END TUTORIAL       (5/5)"
]
SUIT_CHARS = { 'S' => "\u2660", 'C' => "\u2663",
               'D' => "\u2666", 'H' => "\u2665" }
SUIT_WORDS = { 'S' => 'SPADES', 'C' => 'CLUBS',
               'D' => 'DIAMONDS', 'H' => 'HEARTS' }
CARD_VALUES = { '2' => 'TWO', '3' => 'THREE', '4' => 'FOUR',
                '5' => 'FIVE', '6' => 'SIX', '7' => 'SEVEN',
                '8' => 'EIGHT', '9' => 'NINE', '10' => 'TEN',
                'J' => 'JACK', 'Q' => 'QUEEN', 'K' => 'KING',
                'A' => 'ACE' }

que = "\u00BF"
player_hand = []
dealer_hand = []
deck = []
player_wins = 0
dealer_wins = 0
bling = SUIT_CHARS.map { |_k, v| v }
dealer_turn = 'no'
card_num = 1
play = ''
rules = ''
answer = ''
quit = ''

loop do
  if player_wins == 0 && dealer_wins == 0 && player_hand.size == 0
    loop do
      system 'clear'
      3.times { double }
      puts '=' * 50
      puts "WOULD YOU LIKE TO PLAY 21?".center(50)
      puts "ENTER YES OR NO".center(50)
      puts '=' * 50
      play = gets.chomp.downcase
      break if play.start_with?(/(y|n){1}/)
      puts "  PLEASE ENTER 'YES' OR 'NO'"
      sleep(1)
    end
    if play.start_with?('n')
      system 'clear'
      3.times { double }
      puts '=' * 50
      puts 'OK, GOODBYE!'.center(50)
      puts "MAYBE NEXT TIME!".center(50)
      puts '=' * 50
      sleep(2)
      system 'clear'
      break
    end
    break if play.start_with?(/(e|q){1}/)
    loop do
      system 'clear'
      if player_wins == 0
        3.times { double }
        puts '=' * 50
        puts "WOULD YOU LIKE TO KNOW THE RULES?".center(50)
        puts "ENTER YES OR NO".center(50)
        puts '=' * 50
        rules = gets.chomp.downcase
        break if rules.start_with?(/(y|n){1}/)
        puts "  PLEASE ENTER 'YES' OR 'NO'"
        sleep(1)
      end
    end
    tutorial(tutorial_array) if rules.start_with?('y')
  end
  system 'clear'
  if player_wins == 0 && dealer_wins == 0 && deck.size == 0
    3.times { double }
    puts '=' * 50
    puts "GREAT! BEFORE WE START, REMEMBER YOU CAN NOW".center(50)
    puts "TYPE 'EXIT' OR 'QUIT' IN ANY FIELD TO END GAME".center(50)
    puts '=' * 50
    quit = gets.chomp.downcase
    if quit.start_with?(/(e|q){1}/)
      quit_game
      break
    end
    sleep(0.5)
  end
  break if rules.start_with?(/(e|q){1}/)
  if player_hand.size == 0
    card_num = 1
    shuffle_dialog!(deck, player_wins, dealer_wins) if deck.size < 4
    deal_cards!(deck, player_hand, dealer_hand)
  end
  system 'clear'
  puts '=' * 50
  puts "#{(' ' * 34)} GAME INFORMATION"
  puts (' ' * 34) + '-' + "#{bling.sample + bling.sample + bling.sample + bling.sample}" +
                    '-' + "#{bling.sample + bling.sample + bling.sample + bling.sample}" +
                    '-' + "#{bling.sample + bling.sample + bling.sample + bling.sample}" +
                    '-'
  puts (' ' * 7) + "'21'" + ' ' * 23 + "DEALER WINS : #{format('%02d', dealer_wins)}"
  puts (' ' * 34) + "PLAYER WINS : #{format('%02d', player_wins)}"
  puts (' ' * 34) + "UNUSED DECK : #{deck.size}"

  puts '=' * 50
  single
  puts (' ' * 40) + "SCORE : #{dealer_turn != 'no' ? total_score(dealer_hand) : dealer_hand[0][0]}"
  puts "   DEALER HAS : #{show_card_sym(dealer_hand, 0) if dealer_hand.size >= 1}" +
       (' ' * 8) + "#{show_card_sym(dealer_hand, 3) if dealer_hand.size >= 4}"
  single
  if dealer_turn == 'no' && !winner?(dealer_hand)
    puts (' ' * 16) + "#{que} ?"
  else
    puts (' ' * 16) + "#{show_card_sym(dealer_hand, 1) if dealer_hand.size >= 2 && dealer_turn}" +
         (' ' * 8) + "#{show_card_sym(dealer_hand, 4) if dealer_hand.size >= 5}" +
         (' ' * 8) + "#{show_card_sym(dealer_hand, 6) if dealer_hand.size >= 7}"
  end
  single
  puts (' ' * 16) + "#{show_card_sym(dealer_hand, 2) if dealer_hand.size >= 3}" +
       (' ' * 8) + "#{show_card_sym(dealer_hand, 5) if dealer_hand.size >= 6}" +
       (' ' * 8) + "#{show_card_sym(dealer_hand, 7) if dealer_hand.size >= 8}"

  single

  puts (' ' * 40) + "SCORE : #{total_score(player_hand)}"
  puts "   PLAYER HAS : #{show_card_sym(player_hand, 0) if player_hand.size >= 1}" +
       (' ' * 8) + "#{show_card_sym(player_hand, 3) if player_hand.size >= 4}"
  single
  puts (' ' * 16) + "#{show_card_sym(player_hand, 1) if player_hand.size >= 2}" +
       (' ' * 8) + "#{show_card_sym(player_hand, 4) if player_hand.size >= 5}" +
       (' ' * 8) + "#{show_card_sym(player_hand, 6) if player_hand.size >= 7}"
  single
  puts (' ' * 16) + "#{show_card_sym(player_hand, 2) if player_hand.size >= 3}" +
       (' ' * 8) + "#{show_card_sym(player_hand, 5) if player_hand.size >= 6}" +
       (' ' * 8) + "#{show_card_sym(player_hand, 7) if player_hand.size >= 8}"
  single
  puts '=' * 50

  if winner?(dealer_hand) && dealer_hand.size == 2
    if winner?(player_hand)
      puts "  IT'S A PUSH. YOU BOTH HAD 21."
    else
      dealer_wins += 1
      puts '  DEALER WINS WITH NATURAL 21!'
      sleep(0.5)
      puts "  #{show_card_words(dealer_hand, 0)} AND " \
           "#{show_card_words(dealer_hand, 1)}."
    end
    sleep(1)
    puts '  PLEASE HIT ENTER TO DEAL AGAIN.'
    deal = gets.chomp.downcase
    if deal.start_with?(/(e|q){1}/)
      quit_game
      break
    end
    reset_hands!(player_hand, dealer_hand)
    dealer_turn = 'no'
    system 'clear'
    next
  end
  if dealer_turn == 'no'
    if player_hand.size == 2
      puts "  DEALER IS SHOWING THE #{show_card_words(dealer_hand, 0)},"
      sleep(0.5)
      puts "  YOU WERE DEALT THE #{show_card_words(player_hand, 0)},"
      sleep(0.5)
      puts "  AND THE #{show_card_words(player_hand, 1)}."
      sleep(1)
    end
    if player_hand.size > 2
      puts "  YOU WERE DEALT THE #{show_card_words(player_hand, card_num)},"
      sleep(0.5)
      puts "  YOU NOW HAVE #{total_score(player_hand)}."
      if busted?(player_hand)
        puts "  PLAYER BUSTS WITH #{total_score(player_hand)}!"
        sleep(1)
        dealer_wins += 1
        puts '  PLEASE HIT ENTER TO DEAL AGAIN.'
        deal = gets.chomp.downcase
        if deal.start_with?(/(e|q){1}/)
          quit_game
          break
        end
        sleep(1)
        reset_hands!(player_hand, dealer_hand)
        dealer_turn = 'no'
        system 'clear'
        next
      end
    end
    loop do
      puts "  WOULD YOU LIKE TO #{player_hit_or_stay?(player_hand, dealer_hand)}?"
      answer = gets.chomp.downcase
      if answer.start_with?(/(e|q){1}/)
        quit_game
        break
      end
      break if answer.start_with?(/(h|s){1}/)
      puts "  PLEASE ENTER #{player_hit_or_stay?(player_hand, dealer_hand)}."
      sleep(0.5)
    end
    break if answer.start_with?(/(e|q){1}/)
    if answer.start_with?('h')
      shuffle_dialog!(deck, player_wins, dealer_wins) if deck.size == 0
      hit!(player_hand, deck)
      card_num += 1
      next
    end
    if answer.start_with?('s')
      card_num = 1
      dealer_turn = 'yes'
      next
    end
    if busted?(player_hand)
      puts "  PLAYER BUSTS WITH #{total_score(player_hand)}!"
      sleep(1)
      dealer_wins += 1
      puts '  PLEASE HIT ENTER TO DEAL AGAIN.'
      deal = gets.chomp.downcase
      if deal.start_with?(/(e|q){1}/)
        quit_game
        break
      end
      sleep(1)
      reset_hands!(player_hand, dealer_hand)
      dealer_turn = 'no'
      next
    end
    next if answer.start_with?('s')
  end
  if dealer_turn == 'yes'
    if busted?(dealer_hand)
      puts "  DEALER BUSTS WITH #{total_score(dealer_hand)}!"
      sleep(1)
      player_wins += 1
      puts '  PLEASE HIT ENTER TO DEAL AGAIN.'
      deal = gets.chomp.downcase
      if deal.start_with?(/(e|q){1}/)
        quit_game
        break
      end
      sleep(1)
      card_num = 1
      reset_hands!(player_hand, dealer_hand)
      dealer_turn = 'no'
      system 'clear'
      next
    end
    if dealer_hand.size == 2
      puts "  DEALER'S HOLE CARD IS #{show_card_words(dealer_hand, 1)}."
    end
    sleep(0.5)
    puts "  DEALER HAS #{total_score(dealer_hand)}."
    sleep(1)
    if dealer_hit_again?(dealer_hand)
      puts "  DEALER HITS WITH #{total_score(dealer_hand)}."
      shuffle_dialog!(deck, player_wins, dealer_wins) if deck.size == 0
      hit!(dealer_hand, deck)
      card_num += 1
      sleep(0.5)
      puts "  DEALER GETS THE #{show_card_words(dealer_hand, card_num)}."
      sleep(1)
    else
      puts "  DEALER STAYS WITH #{total_score(dealer_hand)}."
      sleep(1)
      dealer_turn = 'no'
    end
    sleep(1)
    next if dealer_turn == 'yes'
  end
  if total_score(player_hand) > total_score(dealer_hand)
    player_wins += 1
    puts "  PLAYER WINS WITH #{total_score(player_hand)}!"
    sleep(1)
    puts '  PLEASE HIT ENTER TO DEAL AGAIN.'
    deal = gets.chomp.downcase
    if deal.start_with?(/(e|q){1}/)
      quit_game
      break
    end
    reset_hands!(player_hand, dealer_hand)
    dealer_turn = 'no'
    system 'clear'
  elsif total_score(player_hand) < total_score(dealer_hand)
    dealer_wins += 1
    puts "  DEALER WINS WITH #{total_score(dealer_hand)}!"
    sleep(1)
    puts '  PLEASE HIT ENTER TO DEAL AGAIN.'
    deal = gets.chomp.downcase
    if deal.start_with?(/(e|q){1}/)
      quit_game
      break
    end
    reset_hands!(player_hand, dealer_hand)
    dealer_turn = 'no'
    system 'clear'
  elsif total_score(player_hand) == total_score(dealer_hand)
    puts "  IT'S A PUSH. BOTH HAVE #{total_score(player_hand)}."
    sleep(1)
    puts '  PLEASE HIT ENTER TO DEAL AGAIN.'
    deal = gets.chomp.downcase
    if deal.start_with?(/(e|q){1}/)
      quit_game
      break
    end
    reset_hands!(player_hand, dealer_hand)
    dealer_turn = 'no'
    system 'clear'
  end
end

if player_wins > 0 || dealer_wins > 0
  system 'clear'
  3.times { double }
  puts '=' * 50
  puts "THANK YOU FOR PLAYING!".center(50)
  puts "LET'S PLAY AGAIN SOON!".center(50)
  puts '=' * 50
  double
  puts '=' * 50
  puts "DEALER HAS #{dealer_wins} WINS.".center(50)
  puts "PLAYER HAS #{player_wins} WINS.".center(50)
  puts '=' * 50
  sleep(2.5)
  system 'clear'
end
