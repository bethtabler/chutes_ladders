


class Game

  attr_accessor :square, :die, :player_location, :player

  def initialize
    create_board
    set_players
  end

  def play!
    player_turn
    roll_dice
    move_piece
    if win? == true
      puts "Yay player #{@player} wins!"
    else
      play!
    end
  end

  def create_board
    board = []
    100.times do
      board << Square.new
    end
  end


  def set_players
    puts "How many players? 2-4"
    player_count = gets.chomp.to_i
    while player_count < 2 || player_count > 4
      puts "Player count must be between 2 and 4."
      player_count = gets.chomp.to_i
    end
    @player_location = 0
  end

  def move_piece
    location = @player_location += @die
  end

  def roll_dice
   @die = rand(1..6)
  end

  def win?
    @player_location >= 100
  end

 


end

class Square

  attr_reader 
  


end






  

  

  




