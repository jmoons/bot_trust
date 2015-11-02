class Robot
  attr_reader   :name, :position, :buttons_to_press, :buttons_pressed, :can_push_button

  INITIAL_STARTING_POSITION = 1
  FINAL_ENDING_POSITION     = 100
  POSITION_MOVE_DISTANCE    = 1

  def initialize(name)
    @position         = INITIAL_STARTING_POSITION
    @name             = name
    @buttons_to_press = []
    @buttons_pressed  = []
    @can_push_button  = not_allowed_to_push_button
  end

  def perform_action
    return if @buttons_to_press.empty?

    current_button_to_press = @buttons_to_press.first.name

    if ( (@position == current_button_to_press) && (@can_push_button) )
      push_button
      return :button_pushed
    elsif( @position > current_button_to_press )
      move_backward
      return :moving
    elsif( @position < current_button_to_press )
      move_forward
      return :moving
    else
      # Nothing to do here
    end

  end

  def move_forward
    @position += POSITION_MOVE_DISTANCE unless @position == FINAL_ENDING_POSITION
  end

  def move_backward
    @position -= POSITION_MOVE_DISTANCE unless @position == INITIAL_STARTING_POSITION
  end

  def push_button
    return unless @can_push_button
    @buttons_pressed << @buttons_to_press.shift
  end

  def add_button_to_press(button)
    return unless button.is_a?(Button)
    @buttons_to_press << button
  end

  def allowed_to_push_button
    @can_push_button = true
  end

  def not_allowed_to_push_button
    @can_push_button = false
  end

end