require './robot.rb'
require './button.rb'

class TestCase

  attr_reader :normalized_test_case_description, :robots

  INSTRUCTION_REGULAR_EXPRESSION = /[a-zA-Z] [0-9]+/

  def initialize(test_case_description)
    @time                             = 0
    @normalized_test_case_description = normalize_test_case_description(test_case_description)
    @robots                           = populate_test_case_robots
    @robots_with_buttons_to_push      = @robots.dup
    @finished_robots                  = []
  end

  private

  def normalize_test_case_description(raw_test_case_description)
    raw_test_case_description.slice(1, raw_test_case_description.length).lstrip.chomp
  end

  def populate_test_case_robots
    robots = {}
    robot_instructions = @normalized_test_case_description.scan(INSTRUCTION_REGULAR_EXPRESSION)

    robot_instructions.each do |robot_button_pair|

      target_robot, target_button = robot_button_pair.split
      target_button               = target_button.to_i

      if ( robots.has_key?(target_robot) )
        robots[target_robot].add_button_to_press( Button.new(target_button) )
      else
        new_robot = Robot.new(target_robot)
        new_robot.add_button_to_press( Button.new(target_button) )
        robots[target_robot] = new_robot
      end
    end
    robots.values
  end

end