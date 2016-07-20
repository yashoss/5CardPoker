require 'card'

class Hand

  attr_reader :type, :cards, :card_count

  HAND_RANKS = [
                :high_card, :pair, :two_pair, :three_kind,
                :straight, :flush, :full_house, :four_kind,
                :straight_flush
               ]

  def initialize(cards)
    @cards = cards
    @card_count = Hash.new {|h,k| h[k] = 0}
    @cards.each do |card|
      @card_count[card.value] += 1
    end
    @type = evaluate
  end

  def evaluate
    return :straight_flush if straight_flush?
    return :four_kind if four_kind?
    return :full_house if full_house?
    return :flush if flush?
    return :straight if straight?
    return :three_kind if three_kind?
    return :two_pair if two_pair?
    return :pair if pair?
    return :high_card
  end

  def beats?(hand)
    my_hand = HAND_RANKS.index(self.type)
    opp_hand = HAND_RANKS.index(hand.type)
    return true if my_hand > opp_hand
    return false if my_hand < opp_hand
    break_tie(hand)
  end

  protected

  def sorted_hand
    sorted = []
    sorted_hash_pairs = @card_count.sort_by {|k,v| k}

    4.downto(1) do |i|
      sorted_hash_pairs.each_with_index do |card, j|
        sorted << card[0] if i == j
      end
    end

    sorted
  end

  private

  def pair?
    @card_count.values.count(2) == 1
  end

  def two_pair?
    @card_count.values.count(2) == 2
  end

  def three_kind?
    @card_count.has_value?(3)
  end

  def four_kind?
    @card_count.has_value?(4)
  end

  def full_house?
    @card_count.has_value?(3) && @card_count.has_value?(2)
  end

  def straight?
    return false if @card_count.size < 5
    card_values = @card_count.keys.sort
    card_values[0..-2].each_with_index do |val, i|
      return false unless card_values[i + 1] - val == 1
    end
    true
  end

  def flush?
    @cards.map(&:suit).uniq.size == 1
  end

  def straight_flush?
    straight? && flush?
  end

  def break_tie(hand)
    my_hand = self.sorted_hand
    opp_hand = hand.sorted_hand
    0.upto(my_hand.size - 1) do |i|
      return true if my_hand[i] > opp_hand[i]
      return false if my_hand[i] < opp_hand[i]
    end
    return nil
  end

end
