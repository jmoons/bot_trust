require './robot.rb'
require './button.rb'

class TestCase

  attr_reader :normalized_test_case_description, :robots, :time, :robots_in_button_press_order

  INSTRUCTION_REGULAR_EXPRESSION = /[a-zA-Z] [0-9]+/

  def initialize(test_case_description)
    @time                             = 0
    @normalized_test_case_description = normalize_test_case_description(test_case_description)
    @robots_in_button_press_order     = []
    @robots                           = populate_test_case_robots

  end

  def complete?
    @robots.all? { |robot| robot.buttons_to_press.length == 0 }
  end

  def perform_test_case_step_independent

    set_robot_button_pushing_permissions_all_true

    @robots.each do | robot |
      robot.perform_action
    end

    @time += 1

  end

  def perform_test_case_step_dependent
    was_button_pushed = nil

    # Set the robot that can push the button
    set_robot_button_pushing_permissions

    @robots.each do | robot |
      action_result = robot.perform_action
      was_button_pushed = true if (action_result == :button_pushed)
    end

    if (was_button_pushed)
      @robots_in_button_press_order.shift
    end

    @time += 1

  end

  private

  def set_robot_button_pushing_permissions_all_true
    @robots.each { |robot| robot.allowed_to_push_button }
  end

  def set_robot_button_pushing_permissions
    @robots_in_button_press_order.first.allowed_to_push_button

    robots_not_allowed_to_press_buttons = @robots.reject { |robot| robot.eql?( @robots_in_button_press_order.first ) }
    robots_not_allowed_to_press_buttons.each { |robot| robot.not_allowed_to_push_button }
  end

  def create_robot_instruction_pairs
    @normalized_test_case_description.scan(INSTRUCTION_REGULAR_EXPRESSION)
  end

  def normalize_test_case_description(raw_test_case_description)
    raw_test_case_description.slice(1, raw_test_case_description.length).lstrip.chomp
  end

  def populate_test_case_robots
    robots = {}
    robot_instructions = create_robot_instruction_pairs

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
      @robots_in_button_press_order << robots[target_robot]
    end
    robots.values
  end

end