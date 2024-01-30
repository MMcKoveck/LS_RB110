require 'yaml'

def single
  puts ''
end

def double
  single
  single
end

def two_strings_dialog(string_one, string_two)
  system 'clear'
  3.times { double }
  stars
  puts string_one.to_s.center(50)
  puts string_two.to_s.center(50)
  stars
end

def busted?(hand)
  total_score(hand) > 21
end

def dealer_hit_again?(hand)
  total_score(hand) < 17
end

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

def winner?(hand)
  total_score(hand) == 21
end

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

def deal_cards!(deck, player, dealer)
  2.times do
    player << deck.shift
    dealer << deck.shift
  end
end

def shuffle_dialog!(deck, player_wins, dealer_wins)
  reset_deck!(deck)
  two_strings_dialog(DIALOG[12], DIALOG[6])
  if player_wins != '0' || dealer_wins != '0'
    double
    stars
    puts "DEALER HAS #{dealer_wins} WINS.".center(50)
    puts "PLAYER HAS #{player_wins} WINS.".center(50)
    stars
  end
  sleep(2)
  system 'clear'
end

def hit!(hand, deck)
  hand << deck.shift
end

def reset_hands!(player, dealer, turn)
  player.clear
  dealer.clear
  turn.replace('no')
end

def show_card_words(hand, card)
  "#{CARD_VALUES[hand[card][0]]} OF #{SUIT_WORDS[hand[card][1]]}"
end

def show_card_sym(hand, card)
  if hand[card][0] == '10'
    "X #{SUIT_CHARS[hand[card][1]]}"
  else
    "#{hand[card][0]} #{SUIT_CHARS[hand[card][1]]}"
  end
end

def total_score(hand)
  values = card_values(hand)
  convert_cards!(values)
  aces = count_aces(values)
  extract_aces!(values)
  add_all_cards(values, aces)
end

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

def card_values(hand)
  hand.map { |card| card[0] }
end

def extract_aces(array)
  array.reject { |card| card == 'A' }
end

def extract_aces!(array)
  array.reject! { |card| card == 'A' }
end

def count_aces(array)
  aces = array.select { |card| card == 'A' }
  aces.count
end

def stars
  puts '=' * 50
end

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

def quit_game
  system 'clear'
  'q'
end

def advance_dialog
  puts DIALOG[13]
  deal = gets.chomp.downcase
  deal.start_with?('q') ? 'quit' : 'continue'
end

def outro(dealer, player)
  two_strings_dialog(DIALOG[8], DIALOG[9])
  double
  stars
  puts "DEALER HAS #{dealer} WINS.".center(50)
  puts "PLAYER HAS #{player} WINS.".center(50)
  stars
  sleep(2.5)
  system 'clear'
end

def ask_to_play
  play = ''
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
    exit
  end
end

def ask_for_rules
  rules = ''
  loop do
    two_strings_dialog(DIALOG[4], DIALOG[1])
    rules = gets.chomp.downcase
    break if rules.start_with?(/(y|n){1}/)
    puts DIALOG[27] + DIALOG[1]
    sleep(1)
  end
  tutorial if rules.start_with?('y')
end

def display_exit_reminder
  two_strings_dialog(DIALOG[5], DIALOG[7])
  sleep(2)
  system 'clear'
end

def check_for_natural(dealer, player, wins, turn)
  if winner?(dealer) && dealer.size == 2
    if winner?(player)
      puts DIALOG[15]
    else
      puts DIALOG[14]
      num = wins.to_i
      wins.replace((num + 1).to_s)
    end
    sleep(0.5)
    puts DIALOG[33] +
         "#{show_card_words(dealer, 0)} AND " \
         "#{show_card_words(dealer, 1)}."
    sleep(1)
    reset_hands!(player, dealer, turn)
  end
end

def display_stats(deck, dealer, player)
  system 'clear'
  stars
  puts (' ' * 34) + DIALOG[16]
  puts (' ' * 34) + bling_line.to_s
  puts "#{(' ' * 7)}'21'#{(' ' * 23)}#{DIALOG[17]}#{format('%02d', dealer)}"
  puts (' ' * 34) + DIALOG[18] + (format('%02d', player)).to_s
  puts (' ' * 34) + DIALOG[19] + deck.size.to_s
  stars
end

def display_dealt_cards(hand, turn, extra)
  que = "\u00BF"
  single
  puts (' ' * 40) + DIALOG[20] + "#{if turn == 'no'
                                      hand[0][0]
                                    else
                                      total_score(hand)
                                    end}"
  puts DIALOG[21] + "#{show_card_sym(hand, 0) if hand.size >= 1}" +
       (' ' * 8) + "#{show_card_sym(hand, 3) if hand.size >= 4}"
  single
  if turn == 'no' && !winner?(hand)
    puts (' ' * 16) + "#{que} ?"
  else
    puts (' ' * 16) + "#{show_card_sym(hand, 1) if hand.size >= 2 && turn}" +
         (' ' * 8) + "#{show_card_sym(hand, 4) if hand.size >= 5}" +
         (' ' * 8) + "#{show_card_sym(hand, 6) if hand.size >= 7}"
  end
  single
  puts (' ' * 16) + "#{show_card_sym(hand, 2) if hand.size >= 3}" +
       (' ' * 8) + "#{show_card_sym(hand, 5) if hand.size >= 6}" +
       (' ' * 8) + "#{show_card_sym(hand, 7) if hand.size >= 8}"
  if extra
    single
    stars
  end
end

def check_for_bust?(hand, num)
  bust = false
  if busted?(hand)
    puts DIALOG[num] + "#{total_score(hand)}!"
    bust = true
  end
  sleep(1)
  bust
end

def game_play_dialog(dealer, player, turn)
  if turn == 'no'
    card_num = (player.size - 1)
    if player.size == 2
      puts DIALOG[23] + "#{show_card_words(dealer, 0)},"
      sleep(1) # 0.5
      puts DIALOG[24] + "#{show_card_words(player, 0)},"
      sleep(1) # 0.5
      puts DIALOG[25] + "#{show_card_words(player, 1)}."
      sleep(1)
    end
    if player.size > 2
      puts DIALOG[24] + "#{show_card_words(player, card_num)},"
      sleep(1)
      puts DIALOG[26] + "#{total_score(player)}."
    end
  end
  if turn == 'yes'
    card_num = (dealer.size - 1)
    if dealer.size == 2
      puts DIALOG[31] + "#{show_card_words(dealer, 1)}."
    end
    if dealer.size > 2
      puts DIALOG[32] + "#{show_card_words(dealer, card_num)}."
    end
    sleep(1)
    puts DIALOG[33] + "#{total_score(dealer)}."
    sleep(1)
  end
end

def add_win(wins, hand, num)
  variable = wins.to_i
  wins.replace((variable + 1).to_s)
  puts DIALOG[num] + "#{total_score(hand)}!"
  sleep(1)
end

def player_game_loop(dealer_hand, player_hand, dealer_wins, player_wins, deck, dealer_turn)
  answer = ''
  loop do
    if check_for_bust?(player_hand, 28)
      sleep(1)
      add_win(dealer_wins, dealer_hand, 38)
      reset_hands!(player_hand, dealer_hand, dealer_turn)
      return 'q' if advance_dialog.start_with?('q')
      return 'dealer_wins'
    end
    loop do
      puts DIALOG[29] + "#{player_hit_or_stay?(player_hand, dealer_hand)}?"
      answer = gets.chomp.downcase
      break if answer.start_with?('q')
      break if answer.start_with?(/(h|s){1}/)
      puts DIALOG[30] + "#{player_hit_or_stay?(player_hand, dealer_hand)}."
      sleep(0.5)
    end
    break if answer.start_with?('q')
    if answer.start_with?('h')
      shuffle_dialog!(deck, player_wins, dealer_wins) if deck.size == 0
      hit!(player_hand, deck)
      return 'hit'
    end
    break if answer.start_with?('s')
  end
  answer
end

def dealer_game_loop(dealer_hand, player_hand, dealer_wins, player_wins, deck, dealer_turn)
  answer = ''
  loop do
    if dealer_hit_again?(dealer_hand)
      puts DIALOG[34] + "#{total_score(dealer_hand)}."
      shuffle_dialog!(deck, player_wins, dealer_wins) if deck.size == 0
      hit!(dealer_hand, deck)
      sleep(2)
      answer = 'hit'
      break
    elsif total_score(dealer_hand) <= 21
      puts DIALOG[35] + "#{total_score(dealer_hand)}."
      sleep(1)
      answer = 'stay'
      break
    end
    sleep(1)
    if check_for_bust?(dealer_hand, 36)
      sleep(1)
      add_win(player_wins, player_hand, 37)
      reset_hands!(player_hand, dealer_hand, dealer_turn)
      return 'q' if advance_dialog.start_with?('q')
      return 'player_wins'
    end
  end
  answer
end

def turn_end(dealer_hand, player_hand, dealer_wins, player_wins, dealer_turn)
  answer = ''
  if total_score(player_hand) > total_score(dealer_hand)
    add_win(player_wins, player_hand, 37)
    sleep(1)
  elsif total_score(player_hand) < total_score(dealer_hand)
    add_win(dealer_wins, dealer_hand, 38)
    sleep(1)
  elsif total_score(player_hand) == total_score(dealer_hand)
    puts DIALOG[39] + "#{total_score(player_hand)}."
    sleep(1)
  end
  if advance_dialog.start_with?('q')
    answer = 'q'
  end
  reset_hands!(player_hand, dealer_hand, dealer_turn)
  answer
end

def get_started(deck, player_hand, player_wins, dealer_hand, dealer_wins)
  if player_hand.size == 0
    shuffle_dialog!(deck, player_wins, dealer_wins) if deck.size < 4
    deal_cards!(deck, player_hand, dealer_hand)
  end
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

player_hand = []
dealer_hand = []
deck = []
player_wins = '0'
dealer_wins = '0'
dealer_turn = 'no'

ask_to_play
ask_for_rules
display_exit_reminder

loop do
  get_started(deck, player_hand, player_wins, dealer_hand, dealer_wins)
  display_stats(deck, dealer_wins, player_wins)
  display_dealt_cards(dealer_hand, dealer_turn, false)
  display_dealt_cards(player_hand, 'yes', true)

  if check_for_natural(dealer_hand, player_hand, dealer_wins, dealer_turn)
    break if advance_dialog.start_with?('q')
    next
  end
  game_play_dialog(dealer_hand, player_hand, dealer_turn)
  if dealer_turn == 'no'
    player_action = player_game_loop(
      dealer_hand, player_hand, dealer_wins, player_wins, deck, dealer_turn
    )
    next if player_action.start_with?('h')
    if player_action.start_with?('q')
      break
    elsif player_action.start_with?('d')
      next
    elsif player_action.start_with?('s')
      dealer_turn = 'yes'
      next
    end
  end

  if dealer_turn == 'yes'
    dealer_action = dealer_game_loop(
      dealer_hand, player_hand, dealer_wins, player_wins, deck, dealer_turn
    )
    next if dealer_action.start_with?('h')
    if dealer_action.start_with?('q')
      break
    elsif dealer_action.start_with?('p')
      dealer_turn = 'no'
      next
    elsif dealer_action.start_with?('s')
      dealer_turn = 'no'
    end
  end

  hand_winner = turn_end(
    dealer_hand, player_hand, dealer_wins, player_wins, dealer_turn
  )
  break if hand_winner.start_with?('q')
  dealer_turn = 'no'
end

outro(dealer_wins, player_wins)
