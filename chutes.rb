
class Square

  attr_reader :number

  def initialize(position)
    @position = position
  end

  def action_square(player)
    true
  end
  
end

class LadderSquare < Square

  def initialize(position, to_position)
    super(position)
    @to_position = to_position
  end

  def action_square(player)
    player.move_to(@to_position)
  end

end

class ChuteSquare < Square

  def initialize(position, to_position)
    super(position)
    @to_position = to_position
  end

  def action_square(player)
    player.move_to(@to_position)
  end

end

class Game

  attr_accessor :square, :player_location, :player, :current_player

  BOARD_SIGILS = {
    '.' => Square,
    'l' => LadderSquare,
    'c' => ChuteSquare
  }
  BOARD_PATTERN = /
    # sigil
    (#{BOARD_SIGILS.keys.map(&Regexp.method(:quote)).join('|')})
    # optional target
    (\d+)?                                               
  /x

  def initialize
    create_board
    set_players
  end

  def play
    player_turn
    roll
    move_piece
    if win? == true
      puts "Yay, #{@current_player} wins!"
    else
      play
    end
  end

  def create_board
    @board = []
    scheme = ".l38..l14....l31......c6....l42......l84.......l44..........c26.c11.l67......c53...c19.l64
    ......l91........l100.......l94...c73.c75..c78"
    scheme.scan(BOARD_PATTERN).each_with_index do |(sigil, target), i|
      klass = BOARD_SIGILS[sigil]
      args = [i]
      if target
        args << Integer(target)
      end
      @board << klass.new(*args)
    end
  end

  def set_players
    puts "How many players? 2-4"
    player_count = gets.chomp.to_i
    while player_count < 2 || player_count > 4
      puts "Player count must be between 2 and 4."
      player_count = gets.chomp.to_i
    end
    @players = []
    player_count.times do |i|
      @players << Player.new(i + 2)
    end
    @current_player = @players.first  
  end


  def player_turn
    @current_player = @players.push(@players.shift).first
  end

  def move_piece
    @current_player.move(roll)
    if @current_player.position > @board.size
      @current_player.position = @board.size
    end
    square = @board[@current_player.position]
    square.action_square(@current_player)
  end

  def roll
   rand(1..6)
  end

  def win?
    @current_player.position >= @board.size
  end

end

class Player

  attr_reader :number, :position

  def initialize(number)
    @number = number
    @position = 0
  end

  def move(n)
    @position += n
  end

  def move_to(i)
    @position = i
  end

  def to_s
    "Player #{@number}"
  end

end





  

  

  




