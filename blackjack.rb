require 'pry'

class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def value
    return 10 if ["J", "Q", "K"].include?(@value)
    return 11 if @value == "A"
    return @value
  end

  def to_s
    "#{@value}-#{suit}"
  end

end

class Deck
  attr_reader :cards

  def initialize
    @cards = Deck.create_cards
  end

  def self.create_cards
    cards = []
    suits = ['spades', 'hearts', 'clubs', 'diamonds']
      suits.each do |suit|
    values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
      values.each do |value|
      cards << Card.new(value, suit)
      end
      end
    cards.shuffle
  end

end


class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def pick_card_from_deck!(deck)
    @cards << deck.cards.shift
  end

  def value
    value = 0
    @cards.each do |card|
      if card.value == 11 && value > 11
        value += 1
      else
        value += card.value
      end
    end
    value
  end

end

class Game
  attr_reader :player_hand, :dealer_hand

  def initialize
    @deck = Deck.new
    @player_hand = Hand.new
    @dealer_hand = Hand.new
    2.times do
      @player_hand.pick_card_from_deck!(@deck)
      @dealer_hand.pick_card_from_deck!(@deck)
    end
  end

  def hit
    @player_hand.pick_card_from_deck!(@deck)
  end

  def stand
    @dealer_hand.pick_card_from_deck!(@deck)
  end

  def status
    puts "Your cards:"
    @player_hand.cards.each do |card|
      puts card.to_s
    end
    puts "Your hand value: #{player_hand.value}"
    puts
    puts "Dealers cards:"
    @dealer_hand.cards.each do |card|
      puts card.to_s
    end
    puts "Dealer hand value: #{dealer_hand.value}"
    puts
  end

  def determine_winner(player_value, dealer_value)
    if player_value == 21
      puts "BLACKJACK, YOU WIN!"
    elsif dealer_value == 21
      puts "BLACKJACK, DEALER WINS!"
    elsif player_value > 21
      puts "You bust!"
      puts "Dealer wins!"
    elsif dealer_value > 21
      puts "Dealer busts!"
      puts "You win!"
    elsif player_value < 21 && (player_value > dealer_value)
      puts "You win!"
    elsif dealer_value <= 21 && (dealer_value > player_value)
      puts "Dealer wins!"
    else dealer_value == player_value && (dealer_value <= 21) && (player_value <= 21)
      puts "It's a tie!"
    end
  end

  def self.play
    game = Game.new
    puts "Lets play MY game of BlackJack!"
    puts
    game.status
    puts
    while true
      if (game.player_hand.value >= 21) || (game.dealer_hand.value >= 21)
        return game.determine_winner(game.player_hand.value, game.dealer_hand.value)
      else
        puts "Hit or stay (h/s):"
        choice = gets.chomp
        if choice.downcase == "h"
          game.hit
          game.status
          puts
        else
          until game.dealer_hand.value >= 17
            game.stand
            print game.status
            puts
          end
            return game.determine_winner(game.player_hand.value, game.dealer_hand.value)
        end
      end
    end
  end

end

Game.play
