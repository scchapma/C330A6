# Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  def initialize (point_array, board)
    super(point_array, board)
  end

  # The constant All_My_Pieces should be declared here
  # class array holding all the pieces and their rotations
  All_My_Pieces = [[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
  rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
  [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
  [[0, 0], [0, -1], [0, 1], [0, 2]]],
  rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
  rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
  rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
  rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z 
  
  # your enhancements here
  rotations([[0, 0], [-1,0], [1, 0], [2, 0], [-2, 0]]), #long-long
  rotations([[0, 0], [1,0], [0, 1]]), # new three-point  
  rotations([[0, -1], [1,-1], [0, 0], [1,0], [0,1]])] # square with appendage
   
  def self.next_piece (board)    
    MyPiece.new(All_My_Pieces.sample, board)
  end

end

class MyBoard < Board
  def initialize (game)
    super(game)
    @current_block = MyPiece.next_piece(self)    
  end
 
  def next_piece
    @current_block = MyPiece.next_piece(self)
    @current_pos = nil
  end

  #store_current - amend for 3 and 5-block pieces
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    last = @current_block.current_rotation.length - 1    
    (0..last).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

  # your enhancements here
  # rotates the current piece 180 degrees
  def rotate_180
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, -2)
    end
    draw
  end

end

class MyTetris < Tetris
  def initialize
    super
    my_key_binding
  end

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  # your enhancements here
  def my_key_binding 
     @root.bind('u', lambda {@board.rotate_180})
  end  

end


