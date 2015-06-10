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
      value += card.value
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
    2.times { @player_hand.pick_card_from_deck!(@deck) }
    2.times { @dealer_hand.pick_card_from_deck!(@deck) }
  end

  def hit
    @player_hand.pick_card_from_deck!(@deck)
  end

  def stand
    @dealer_hand.pick_card_from_deck!(@deck)
  end

  def status
    puts "Your cards:"
    @player_hand.cards.each { |card| p card.to_s }
    puts "Your hand value: #{player_hand.value}"
    puts
    puts "Dealers cards:"
    @dealer_hand.cards.each { |card| p card.to_s }
    puts "Dealer hand value: #{dealer_hand.value}\n"
  end

  def determine_winner(player_value, dealer_value)
    if player_value == 21
      puts "BLACKJACK, you win!"
    end
    if player_value > 21
      puts "Player busts!"
      puts "Dealer wins!"
    end
    if dealer_value > 21
      puts "Dealer busts!"
      puts "Player wins!"
    end
    if player_value < 21 && (player_value > dealer_value)
      puts "Player wins!"
    end
    if dealer_value <= 21 && (dealer_value > player_value)
      puts "Dealer wins!"
    end
    if dealer_value == player_value && (dealer_value <= 21) && (player_value <= 21)
      puts "It's a tie!"
    end
  end

  def self.play
    puts "Lets play MY game of BlackJack!"
    puts
    game = Game.new
    print game.status
    puts
    puts "Hit or stay (h/s):"
    while true
      choice = gets.chomp
      if choice == "h"
        game.hit
        print game.status
        puts
        puts "Hit or stay(h/s):"
      elsif choice == "s"
        while (game.dealer_hand.value < 17) && (game.player_hand.value < 22) do
          game.stand
          print game.status
          puts
        end
        return game.determine_winner(game.player_hand.value, game.dealer_hand.value)
      end
    end
  end

end

Game.play
