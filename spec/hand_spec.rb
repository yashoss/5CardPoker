require 'rspec'
require 'hand'
require 'deck'
require 'card'

describe Hand do

  let(:card1) {double("card1", value: 5, suit: :h)}
  let(:card2) {double("card2", value: 9, suit: :s)}
  let(:card3) {double("card3", value: 7, suit: :d)}
  let(:card4) {double("card4", value: 5, suit: :c)}
  let(:card5) {double("card5", value: 1, suit: :h)}

  let(:card6) {double("card6", value: 13, suit: :h)}
  let(:card7) {double("card7", value: 12, suit: :s)}
  let(:card8) {double("card8", value: 11, suit: :d)}
  let(:card9) {double("card9", value: 10, suit: :c)}
  let(:card10) {double("card10", value: 9, suit: :h)}

  let(:card11) {double("card11", value: 8, suit: :h)}
  let(:card12) {double("card12", value: 1, suit: :s)}
  let(:card13) {double("card13", value: 5, suit: :d)}
  let(:card14) {double("card14", value: 5, suit: :s)}
  let(:card15) {double("card15", value: 2, suit: :h)}

  let(:card16) {double("card16", value: 1, suit: :d)}
  let(:card17) {double("card17", value: 1, suit: :c)}
  let(:card18) {double("card18", value: 2, suit: :d)}

  let(:h_flush) { Hand.new([card6, card10, card15, card11, card5]) }
  let(:h_straight) { Hand.new([card6, card7, card8, card9, card10]) }
  let(:h_three) { Hand.new([card1, card4, card14, card6, card12]) }
  let(:h_four) { Hand.new([card1, card4, card14, card13, card12]) }
  let(:h_pair) { Hand.new([card1, card2, card3, card4, card5]) }

  describe "#initialize" do
    it "stores the hand" do
      expect(h_pair.cards).to eq([card1, card2, card3, card4, card5])
    end
  end

  describe "#evaluate" do
    context "evaluates different hands" do

      it "finds single pairs" do
        expect(h_pair.type).to eq(:pair)
      end

      it "finds flushes" do
        expect(h_flush.type).to eq(:flush)
      end

      it "finds straights" do
        expect(h_straight.type).to eq(:straight)
      end

      it "finds three of a kinds" do
        expect(h_three.type).to eq(:three_kind)
      end

      it "finds four of a kinds" do
        expect(h_four.type).to eq(:four_kind)
      end

    end
  end

  describe "#beats?" do
    context "returns true if hand beats opponent hand" do
      it "evaluates hands of different types" do
        expect(h_three.beats?(h_pair)).to be true
      end

      it "evaluates same types of hands by kicker" do
        hand1 = h_pair #pair of 5 with higher kicker
        hand2 = Hand.new([card11, card12, card13, card14, card15]) #pair of 5 with lower kicker

        expect(hand1.beats?(hand2)).to be true
      end

      it "evaluates different pairs" do
        card = double("card", value: 1, suit: :c)
        hand1 = h_pair #pair of 5
        hand2 = Hand.new([card, card12, card8, card9, card10]) #pair of Aces
        expect(hand2.beats?(hand1)).to be true
      end

    end

    context "return false if hand is beaten by opponent hand" do
      it "returns false if pair is compaired to a full house" do
        expect(h_pair.beats?(h_flush)).to be false
      end

      it "returns false when a lower kicker is compared to a higher kicker" do
        hand1 = h_pair #pair of 5 with higher kicker
        hand2 = Hand.new([card11, card12, card13, card14, card15]) #pair of 5 with lower kicker

        expect(hand2.beats?(hand1)).to be false
      end
    end

    it "returns nil if tie" do
      hand1 = Hand.new([card1, card4, card5, card12, card15])
      hand2 = Hand.new([card13, card17, card18, card14, card16])
      expect(hand1.beats?(hand2)).to eq(nil)
    end

  end

end
