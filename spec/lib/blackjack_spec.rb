require "rspec"
require_relative "../../blackjack"

describe Card do
  it "should have a suit and a value" do
    card = Card.new(10, "clubs")
    expect(card.suit).to eq("clubs")
    expect(card.value).to eq(10)
  end

  it "should have a value of 10 for facecards" do
    card = Card.new("Q", "hearts")
    expect(card.value).to eq(10)
  end

  it "should have a value of 11 for Ace" do
    card = Card.new("A", "spades")
    expect(card.value).to eq(11)
  end

  it "should format each card" do
    card = Card.new("A", "spades")
    expect(card.to_s).to eq("A-spades")
  end
end

describe Deck do
  it "should create 52 cards" do
    deck = Deck.create_cards
    expect(deck.length).to eq(52)
  end

  it "should have 52 cards in a new deck" do
    deck = Deck.new.cards
    expect(deck.length).to eq (52)
  end
end

describe Game do
  it "should have a players hand" do
    game = Game.new.player_hand.cards
    expect(game.length).to eq(2)
  end

  it "should have a dealers hand" do
    game = Game.new.dealer_hand.cards
    expect(game.length).to eq(2)
  end

  it "should be able to hit" do
    game = Game.new
    game.hit
    expect(game.player_hand.cards.length).to eq(3)
  end
end
