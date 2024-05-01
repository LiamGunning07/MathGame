require_relative "Player"

class MathGame
  def initialize
    @players = [Player.new("Player 1"), Player.new("Player 2")]
    @current_player = 0
  end

  def generate_question
    num1 = rand(1..20)
    num2 = rand(1..20)
    { question: "What is #{num1} + #{num2}?", answer: num1 + num2 }
  end

  def play_round
    question = generate_question
    puts "#{@players[@current_player].name}, #{question[:question]}"
    answer = gets.chomp.to_i

    if answer == question[:answer]
      puts "Correct! #{@players[@current_player].name}"
    else
      puts "Incorrect! #{@players[@current_player].name}"
      @players[@current_player].lose_life
    end

    display_scores
    switch_player
  end

  def display_scores
    @players.each { |player| puts "#{player.name} lives: #{player.lives}" }
    puts "--- NEW TURN ---"
  end

  
  def switch_player
    @current_player = (@current_player + 1) % 2
  end

  def game_over?
    @players.any? { |player| player.lives <= 0 }
  end

  def announce_winner
    winner = @players.find { |player| player.lives > 0 }
    loser = @players.find { |player| player.lives <= 0 }

    puts "#{winner.name} wins with #{winner.lives} lives remaining!"
    puts "#{loser.name} scored #{3 - loser.lives} points."
  end

  def start_game
    until game_over?
      play_round
    end

    announce_winner
  end
end

game = MathGame.new
game.start_game
