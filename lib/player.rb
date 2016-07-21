require_relative 'card'

class HumanPlayer

  attr_reader :name, :bankroll
  attr_accessor :cards, :fold

  def initialize(name = "Human", bankroll = 1_000)
    @name = name
    @bankroll = bankroll
    @cards = []
    @fold = false
  end

  def get_cards(cards)
    @cards += cards
  end

  def display_cards
    system('clear')
    hand = []
    @cards.each do |card|
      hand << card.to_s
    end
    puts "#{name}: #{hand.join(" ")}\n"
  end

  def gets_move
    puts "[F] for Fold, [S] for See, [R] for Raise, [Any Key] for Check"
    move = gets.chomp.upcase
  end

  def discard
    puts "Which cards do you want to discard?"
    trash = gets.chomp.split(",").map(&:to_i)
    discarded_cards = []
    trash.each do |i|
      discarded_cards << @cards[i]
    end
    @cards -= discarded_cards
    trash.size
  end

  def see(amount)
    @bankroll -= amount
    amount
  end

  def bet(amount)
    bet = 0
    loop do
      puts "How much would you like to raise?"
      bet = gets.chomp.to_i + amount
      break unless bet >= @bankroll
      puts "Not enough in bankroll. Try again."
    end
    @bankroll -= bet
    bet
  end

  def pay(prize)
    @bankroll += prize
  end

end
