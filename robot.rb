class Robot
  attr_reader :name, :position

  INITIAL_STARTING_POSITION = 1
  FINAL_ENDING_POSITION     = 100
  POSITION_MOVE_DISTANCE    = 1

  def initialize(name)
    @position = INITIAL_STARTING_POSITION
    @name     = name
  end

  def move_forward
    @position += 1 unless @position == FINAL_ENDING_POSITION
  end

  def move_backward
    @position -= 1 unless @position == INITIAL_STARTING_POSITION
  end

end