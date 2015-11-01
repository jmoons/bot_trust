class Orchestrator

  attr_reader :orange_buttons, :blue_buttons

  INSTRUCTION_REGULAR_EXPRESSION = /[a-zA-Z] [0-9]+/

  def initialize(buttons_to_press)
    @robot_instructions = buttons_to_press.scan(INSTRUCTION_REGULAR_EXPRESSION)
    @orange_buttons     = []
    @blue_buttons       = []

    populate_button_schedules
  end

  private

  def populate_button_schedules
    @robot_instructions.each do |robot_button_pair|

      target_robot, target_button = robot_button_pair.split
      target_button               = target_button.to_i
      case target_robot.upcase
        when "O"
          @orange_buttons << target_button
        when "B"
          @blue_buttons << target_button
        else
      end
    end
  end
end
