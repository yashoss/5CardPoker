require_relative 'deck'
require_relative 'card'
require_relative 'hand'
require_relative 'player'

class Poker

  attr_reader :players, :prev_bet, :deck, :pot

  def initialize(players)
    @players = players
    @deck = nil
    @pot = 0
    @prev_bet = 0
  end

  def play

  end

  def play_turn
    @deck = Deck.new
    @deck.shuffle!
    deal_setup
    bet_round
    exchange_cards
    bet_round
    pay_winner
    @players.rotate!
  end

  def bet_round
    @prev_bet = 0
    @players.each do |player|
      next if player.fold
      player.display_cards
      puts "#{player.name}'s turn to bet"
      puts "#{player.name}'s bankroll: #{player.bankroll}"
      puts "Pot: #{pot}"
      puts "Previous bet: #{prev_bet}"
      move = player.gets_move
      case move
      when "F"
        player.fold = true
      when "S"
        @pot += player.see(prev_bet)
      when "R"
        bet = player.bet(prev_bet)
        @pot += bet
        @prev_bet = bet
      end
    end
  end

  def exchange_cards
    @players.each do |player|
      next if player.fold
      player.display_cards
      puts "#{player.name}'s turn to exchange cards"
      num = player.discard
      deal_cards(num, player)
      player.display_cards
    end
  end

  def deal_setup
    print_shuffling
    @pot = 0
    @players = @players.select{|player| player.bankroll > 0}
    @players.each do |player|
      player.fold = false
      player.cards = []
      deal_cards(5, player)
    end
  end

  def deal_cards(num, player)
    player.get_cards(deck.deal(num))
  end

  def pay_winner
    winning_player = []
    @players.each do |player|
      next if player.fold
      winning_player << player if winning_player.empty?
      hand1 = Hand.new(winning_player[0].cards)
      hand2 = Hand.new(player.cards)
      case hand1.beats?(hand2)
      when false
        winning_player = [player]
      when nil
        winning_player << player
      end
    end

    names = winning_player.map(&:name).join(" ")
    puts "The winning players is #{names}."
    prize = pot / winning_player.size
    winning_player.each{|player| player.pay(prize)}
    puts "Prize is $#{prize}."
  end

  def print_shuffling
    system('clear')
    print "Shuffling"; sleep(1)
    3.times { print "."; sleep(1)}
  end

end

if __FILE__ == $PROGRAM_NAME
  player1 = HumanPlayer.new("Marc")
  player2 = HumanPlayer.new("Yasin")
  player3 = HumanPlayer.new("Sean")
  player4 = HumanPlayer.new("John")
  game = Poker.new([player1, player2, player3, player4])
  game.play_turn
end
