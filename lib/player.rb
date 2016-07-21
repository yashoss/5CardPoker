require 'hand'

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
    @cards.each do |card|
      puts card.to_s
    end
  end

  def gets_move
    puts "C for Check, F for Fold, S for See, R for Raise"
    move = gets.chomp
  end

  def discard
    puts "Which cards do you want to discard?"
    trash = parse_input(gets.chomp)
    trash.each do |i|
      @cards.delete_at(i)
    end
    trash.size
  end

  def see(amount)
    @bankroll -= amount
  end

  def bet(amount)
    puts "How much would you like to raise?"
    bet = gets.chomp.to_i + amount
    @bankroll -= bet
    bet
  end

  def pay(prize)
    @bankroll += prize
  end

end
