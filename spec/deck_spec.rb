require 'rspec'
require 'deck'

describe Deck do

  let(:deck) { Deck.new }

  describe "#initialize" do
    it "populates the deck" do
      expect(deck.cards.size).to eq(52)
    end
  end

  describe "#shuffle!" do
    it "shuffles the deck" do
      original_deck = deck.cards.dup
      deck.shuffle!
      expect(deck.cards).to_not eq(original_deck)
    end
  end

  describe "#deal" do
    let(:card1) { double('card1', value: 2, suit: :h) }
    let(:card2) { double('card2', value: 3, suit: :h) }
    let(:card3) { double('card3', value: 4, suit: :h) }

    it "deals cards and returns array of cards" do
      hand = deck.deal(3)
      expect(hand[0].value).to eq(card1.value)
      expect(hand[1].value).to eq(card2.value)
      expect(hand[2].value).to eq(card3.value)
      expect(deck.size).to eq(49)
    end

    it "raises an error if not enough cards to deal" do
      expect{ deck.deal(53) }.to raise_error(DeckError)
    end
  end

end
