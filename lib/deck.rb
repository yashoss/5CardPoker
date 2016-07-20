require 'card'

class DeckError < StandardError
end

class Deck

  attr_reader :cards

  def initialize
    @cards = []
    populate_deck
  end

  def populate_deck
    [:h, :d, :c, :s].each do |suit|
      (1..13).each do |value|
        @cards << Card.new(value, suit)
      end
    end
  end

  def size
    @cards.size
  end

  def shuffle!
    @cards.shuffle!
  end

  def deal(num)
    raise DeckError if num > size
    hand = []
    num.times { hand << @cards.shift }
    hand
  end

  def [](pos)
    @cards[pos]
  end

  def []=(pos, value)
    @cards[pos] = value
  end
end
