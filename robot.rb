class Robot
  attr_reader :name, :position, :buttons_to_press

  INITIAL_STARTING_POSITION = 1
  FINAL_ENDING_POSITION     = 100
  POSITION_MOVE_DISTANCE    = 1

  def initialize(name)
    @position         = INITIAL_STARTING_POSITION
    @name             = name
    @buttons_to_press = []
  end

  def move_forward
    @position += POSITION_MOVE_DISTANCE unless @position == FINAL_ENDING_POSITION
  end

  def move_backward
    @position -= POSITION_MOVE_DISTANCE unless @position == INITIAL_STARTING_POSITION
  end

  def push_button
    # Nothing to do here
  end

  def add_button_to_press(button)
    return unless button.is_a?(Button)
    @buttons_to_press << button
  end

end