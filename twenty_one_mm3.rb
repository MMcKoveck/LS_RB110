####################################
####################################
#  ALL THE FUNCTIONALITY OF mm
#  USING YAML FILE
#  STILL SOME RUBOCOP SHENANIGANS
#
####################################
####################################
require 'yaml'

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

# INPUT : two strings
# OUTPUT : dialog page
# RETURN : nil
# MUTATES : no
def two_strings_dialog(string_one, string_two)
  system 'clear'
  3.times { double }
  stars
  puts string_one.to_s.center(50)
  puts string_two.to_s.center(50)
  stars
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
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
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
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity

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
def reset_deck!(new_deck)
  suit_letters = ['S', 'C', 'D', 'H']
  values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  counter = 0
  new_deck.clear
  new_suit = []
  4.times do
    new_suit << values
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
  reset_deck!(deck)
  two_strings_dialog(DIALOG[12], DIALOG[6])
  if player_wins > 0 || dealer_wins > 0
    double
    stars
    puts "DEALER HAS #{dealer_wins} WINS.".center(50)
    puts "PLAYER HAS #{player_wins} WINS.".center(50)
    stars
  end
  sleep(2)
  # system 'clear' # ?
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
def reset_hands!(player, dealer, turn) # RETURNS EMPTY ARRAY
  player.clear
  dealer.clear
  turn.replace('no')
  system 'clear'
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
# rubocop:disable Metrics/CyclomaticComplexity
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
  total
end
# rubocop:enable Metrics/CyclomaticComplexity

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
# rubocop:disable Metrics/MethodLength
def tutorial
  counter = 0
  system 'clear'
  5.times do
    4.times do
      stars
      2.times do
        puts TUTORIAL_ARRAY[counter].center(50)
        counter += 1
      end
      stars
      sleep(1.5)
    end
    stars
    puts TUTORIAL_ARRAY[counter]
    stars
    counter += 1
    gets
    system 'clear'
  end
end
# rubocop:enable Metrics/MethodLength

# INPUT : none
# OUTPUT : exit page
# RETURN : true
# MUTATES : no
def quit_game(dealer, player)
  if dealer == 0 && player == 0
    two_strings_dialog(DIALOG[10], DIALOG[11])
    sleep(2)
  end
  system 'clear'
end

# INPUT : none
# OUTPUT : none
# RETURN : variable bling line
# MUTATES : no
def bling_line
  bling = SUIT_CHARS.map { |_k, v| v }
  string = ''
  dashes = 0
  loop do
    string << '-'
    dashes += 1
    break if dashes == 4
    4.times { string << bling.sample }
  end
  string
end

# INPUT : none
# OUTPUT : enter dialog
# RETURN : nil
# MUTATES : no
def advance_dialog
  puts DIALOG[13]
end

# INPUT : none
# OUTPUT : exit dialog
# RETURN : nil or true
# MUTATES : no
def quit_check(dealer, player)
  deal = gets.chomp.downcase
  if deal.start_with?('q')
    quit_game(dealer, player)
  end
end

# INPUT : none
# OUTPUT : final exit dialog
# RETURN : true
# MUTATES : no
def outro(dealer_wins, player_wins)
  two_strings_dialog(DIALOG[8], DIALOG[9])
  double
  stars
  puts "DEALER HAS #{dealer_wins} WINS.".center(50)
  puts "PLAYER HAS #{player_wins} WINS.".center(50)
  stars
  sleep(2.5)
  system 'clear'
end
###############################################

###############################################
TEXT_HASH = YAML.load_file('twenty_one_text.yml')
TUTORIAL_ARRAY = TEXT_HASH['tutorial_array_y']
DIALOG = TEXT_HASH['dialog_y']
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
dealer_turn = 'no'
card_num = 1
play = ''
rules = ''
answer = ''

loop do
  if player_wins == 0 && dealer_wins == 0 && player_hand.size == 0
    loop do
      two_strings_dialog(DIALOG[0], DIALOG[1])
      play = gets.chomp.downcase
      break if play.start_with?(/(y|n){1}/)
      puts DIALOG[27] + DIALOG[1]
      sleep(1)
    end
    if play.start_with?('n')
      two_strings_dialog(DIALOG[2], DIALOG[3])
      sleep(2)
      system 'clear'
      break
    end
    loop do
      if player_wins == 0
        two_strings_dialog(DIALOG[4], DIALOG[1])
        rules = gets.chomp.downcase
        break if rules.start_with?(/(y|n){1}/)
        puts DIALOG[27] + DIALOG[1]
        sleep(1)
      end
    end
    tutorial if rules.start_with?('y')
  end
  if player_wins == 0 && dealer_wins == 0 && deck.size == 0
    two_strings_dialog(DIALOG[5], DIALOG[7])
    sleep(2)
    system 'clear'
  end
  if player_hand.size == 0
    card_num = 1
    shuffle_dialog!(deck, player_wins, dealer_wins) if deck.size < 4
    deal_cards!(deck, player_hand, dealer_hand)
  end
  # rubocop:disable Layout/LineLength
  # rubocop:disable Style/RedundantInterpolation
  system 'clear'
  stars
  puts (' ' * 34) + DIALOG[16]
  puts (' ' * 34) + bling_line.to_s
  puts "#{(' ' * 7)}'21'#{(' ' * 23)}#{DIALOG[17]}#{format('%02d', dealer_wins)}"
  puts (' ' * 34) + DIALOG[18] + "#{format('%02d', player_wins)}"
  puts (' ' * 34) + DIALOG[19] + "#{deck.size}"
  stars
  single
  puts (' ' * 40) + DIALOG[20] + "#{if dealer_turn == 'no'
                                      dealer_hand[0][0]
                                    else
                                      total_score(dealer_hand)
                                    end}"
  puts DIALOG[21] + "#{show_card_sym(dealer_hand, 0) if dealer_hand.size >= 1}" +
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

  puts (' ' * 40) + DIALOG[20] + "#{total_score(player_hand)}"
  puts DIALOG[22] + "#{show_card_sym(player_hand, 0) if player_hand.size >= 1}" +
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
  stars
  # rubocop:enable Layout/LineLength
  # rubocop:enable Style/RedundantInterpolation
  if winner?(dealer_hand) && dealer_hand.size == 2
    if winner?(player_hand)
      puts DIALOG[15]
    else
      dealer_wins += 1
      puts DIALOG[14]
      sleep(0.5)
      puts "  #{show_card_words(dealer_hand, 0)} AND " \
           "#{show_card_words(dealer_hand, 1)}."
    end
    sleep(1)
    advance_dialog
    break if quit_check(dealer_wins, player_wins) == true
    reset_hands!(player_hand, dealer_hand, dealer_turn)
    next
  end
  if dealer_turn == 'no'
    if player_hand.size == 2
      puts DIALOG[23] + "#{show_card_words(dealer_hand, 0)},"
      sleep(1) # 0.5
      puts DIALOG[24] + "#{show_card_words(player_hand, 0)},"
      sleep(1) # 0.5
      puts DIALOG[25] + "#{show_card_words(player_hand, 1)}."
      sleep(1)
    end
    if player_hand.size > 2
      puts DIALOG[24] + "#{show_card_words(player_hand, card_num)},"
      sleep(1)
      puts DIALOG[26] + "#{total_score(player_hand)}."
      if busted?(player_hand)
        puts DIALOG[28] + "#{total_score(player_hand)}!"
        dealer_wins += 1
        sleep(1)
        advance_dialog
        break if quit_check(dealer_wins, player_wins) == true
        sleep(1)
        reset_hands!(player_hand, dealer_hand, dealer_turn)
        next
      end
    end
    loop do
      puts DIALOG[29] + "#{player_hit_or_stay?(player_hand, dealer_hand)}?"
      answer = gets.chomp.downcase
      if answer.start_with?('q')
        quit_game(dealer_wins, player_wins)
        break
      end
      break if answer.start_with?(/(h|s){1}/)
      puts DIALOG[30] + "#{player_hit_or_stay?(player_hand, dealer_hand)}."
      sleep(0.5)
    end
    break if answer.start_with?('q')
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
  end
  if dealer_turn == 'yes'
    if dealer_hand.size == 2
      puts DIALOG[31] + "#{show_card_words(dealer_hand, 1)}."
    end
    if dealer_hand.size > 2
      puts DIALOG[32] + "#{show_card_words(dealer_hand, card_num)}."
    end
    sleep(1)
    puts DIALOG[33] + "#{total_score(dealer_hand)}."
    sleep(1)
    if dealer_hit_again?(dealer_hand)
      puts DIALOG[34] + "#{total_score(dealer_hand)}."
      shuffle_dialog!(deck, player_wins, dealer_wins) if deck.size == 0
      hit!(dealer_hand, deck)
      card_num += 1
      sleep(2)
      next
    elsif total_score(dealer_hand) <= 21
      puts DIALOG[35] + "#{total_score(dealer_hand)}."
      sleep(1)
      dealer_turn = 'no'
    end
    sleep(1)
    if busted?(dealer_hand)
      puts DIALOG[36] + "#{total_score(dealer_hand)}!"
      player_wins += 1
      sleep(1)
      advance_dialog
      break if quit_check(dealer_wins, player_wins) == true
      card_num = 1
      sleep(1)
      reset_hands!(player_hand, dealer_hand, dealer_turn)
      next
    end
    next if dealer_turn == 'yes'
  end
  if total_score(player_hand) > total_score(dealer_hand)
    player_wins += 1
    puts DIALOG[37] + "#{total_score(player_hand)}!"
    sleep(1)
    advance_dialog
    break if quit_check(dealer_wins, player_wins) == true
    reset_hands!(player_hand, dealer_hand, dealer_turn)
  elsif total_score(player_hand) < total_score(dealer_hand)
    dealer_wins += 1
    puts DIALOG[38] + "#{total_score(dealer_hand)}!"
    sleep(1)
    advance_dialog
    break if quit_check(dealer_wins, player_wins) == true
    reset_hands!(player_hand, dealer_hand, dealer_turn)
  elsif total_score(player_hand) == total_score(dealer_hand)
    puts DIALOG[39] + "#{total_score(player_hand)}."
    sleep(1)
    advance_dialog
    break if quit_check(dealer_wins, player_wins) == true
    reset_hands!(player_hand, dealer_hand, dealer_turn)
  end
end

outro(dealer_wins, player_wins) if player_wins > 0 || dealer_wins > 0
