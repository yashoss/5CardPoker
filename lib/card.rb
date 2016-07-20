require 'colorize'

class Card

  SUITS = { h: "♥︎", c: "♣︎", d: "♦︎", s: "♠︎"}
  VALUES = {
    1 => "A", 2 => "2", 3 => "3", 4 => "4", 5 => "5",
    6 => "6", 7 => "7", 8 => "8", 9 => "9", 10 => "10",
    11 => "J", 12 => "Q", 13 => "K", 14 => "A" }

  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    "#{VALUES[value]}#{SUITS[suit]}".colorize(color: color, background: :light_white)
  end

  def color
    return :red if suit == :h || suit == :d
    return :black if suit == :s || suit == :c
  end

end
