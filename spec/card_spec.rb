require 'rspec'
require 'card'

describe Card do

  subject(:card) {Card.new(7, :h)}
  describe "#initialize" do
    it "assigns a card value" do
      expect(card.value).to eq(7)
    end

    it "assigns a card suit" do
      expect(card.suit).to eq(:h)
    end
  end

  describe "#color" do
    it "returns the card color" do
      expect(card.color).to eq(:red)
    end
  end

  describe "#to_s" do
    it "returns the card value and symbol in color" do
      puts card.to_s
      expect(card.to_s).to eq("\e[0;31;107m7♥︎\e[0m")
    end
  end

end
