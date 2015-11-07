require_relative '../robot'
require_relative '../button'

describe "#Robot" do

  before :each do
    @test_robot = Robot.new("Batman")
  end

  it "has a name" do
    expect(@test_robot.name).to eq("Batman")
  end

  it "starting position is 1" do
    expect(@test_robot.position).to eq(Robot::INITIAL_STARTING_POSITION)
  end

  it "initially has no buttons to press" do
    expect(@test_robot.buttons_to_press).to be_empty
  end

  it "initially is not allowed to push buttons" do
    expect(@test_robot.can_push_button).to be false
  end

  it "#move_forward advances the robot by one only if not at position 100" do
    current_position = @test_robot.position
    @test_robot.move_forward
    expect(@test_robot.position).to eq(current_position + Robot::POSITION_MOVE_DISTANCE)
  end

  it "#move_forward does not advance the robot if at the end of the hallway" do
    (Robot::INITIAL_STARTING_POSITION ... Robot::FINAL_ENDING_POSITION).each do
      @test_robot.move_forward
    end

    expect(@test_robot.position).to eq(Robot::FINAL_ENDING_POSITION)
    @test_robot.move_forward
    expect(@test_robot.position).to eq(Robot::FINAL_ENDING_POSITION)

  end

  it "#move_backward retreats the robot by one" do
    (Robot::INITIAL_STARTING_POSITION ... Random.new.rand(10..20)).each do
      @test_robot.move_forward
    end
    current_position = @test_robot.position
    @test_robot.move_backward
    expect(@test_robot.position).to eq(current_position - Robot::POSITION_MOVE_DISTANCE)
  end

  it "#move_backward does not advance the robot if at the beginning of the hallway" do
    @test_robot.move_backward
    expect(@test_robot.position).to eq(Robot::INITIAL_STARTING_POSITION)
  end

  it "#push_button does not change the Robot's position" do
    @test_robot.push_button
    expect(@test_robot.position).to eq(Robot::INITIAL_STARTING_POSITION)
  end

  it "#push_button does nothing if the Robot is not allowed to push buttons" do
    button1 = Button.new(1)
    button2 = Button.new(2)

    @test_robot.add_button_to_press( button1 )
    @test_robot.add_button_to_press( button2 )
    expect(@test_robot.buttons_to_press).to contain_exactly( button1, button2 )

    expect(@test_robot.can_push_button).to be false
    @test_robot.push_button
    expect(@test_robot.buttons_to_press).to contain_exactly( button1, button2 )

  end

  it "#push_button moves the first button from buttons_to_press to buttons_pressed" do
    button1 = Button.new(1)
    button2 = Button.new(2)

    @test_robot.add_button_to_press( button1 )
    @test_robot.add_button_to_press( button2 )
    expect(@test_robot.buttons_to_press).to contain_exactly( button1, button2 )

    @test_robot.allowed_to_push_button
    @test_robot.push_button

    expect(@test_robot.buttons_to_press).to contain_exactly( button2 )
    expect(@test_robot.buttons_pressed).to contain_exactly( button1 )
  end

  it "#add_button_to_press adds a Button for the robot to press" do
    expect(@test_robot.buttons_to_press).to be_empty
    button = Button.new(5)
    @test_robot.add_button_to_press(button)
    expect(@test_robot.buttons_to_press).to include(button)
  end

  it "#add_button_to_press only accepts #Button objects" do
    button = 5
    @test_robot.add_button_to_press(button)
    expect(@test_robot.buttons_to_press).to be_empty
  end

  it "#perform_action will advance the robot to a button that is ahead" do
    button = Button.new(5)
    @test_robot.add_button_to_press(button)

    expect(@test_robot.position).to equal(Robot::INITIAL_STARTING_POSITION)
    expect(@test_robot).to receive(:move_forward)
    @test_robot.perform_action

  end

  it "#perform_action will retreat the robot to a button that is behind" do
    button_position = 5
    button          = Button.new(button_position)
    @test_robot.add_button_to_press(button)

    (Robot::INITIAL_STARTING_POSITION .. button_position).each do |iterator|
      @test_robot.move_forward
    end

    expect(@test_robot.position).to equal( button_position + 1 )
    expect(@test_robot).to receive(:move_backward)
    @test_robot.perform_action

  end


  it "#perform_action will return :moving when the robot advances" do
    button = Button.new(5)
    @test_robot.add_button_to_press(button)

    expect(@test_robot.perform_action).to eq(:moving)

  end

  it "#perform_action will return :moving when the robot retreats" do
    button_position = 5
    button          = Button.new(button_position)
    @test_robot.add_button_to_press(button)

    (Robot::INITIAL_STARTING_POSITION .. button_position).each do |iterator|
      @test_robot.move_forward
    end

    expect(@test_robot.perform_action).to eq(:moving)

  end

  it "#perform_action will call #push_button when robot is on a button" do
    button = Button.new(1)
    @test_robot.add_button_to_press(button)

    @test_robot.allowed_to_push_button

    expect(@test_robot.position).to equal(Robot::INITIAL_STARTING_POSITION)
    expect(@test_robot).to receive(:push_button)
    @test_robot.perform_action

  end

  it "#perform_action will return :button_pushed when robot pushes button" do
    button = Button.new(1)
    @test_robot.add_button_to_press(button)

    @test_robot.allowed_to_push_button

    expect(@test_robot.perform_action).to eq(:button_pushed)

  end

  it "#allowed_to_push_button will set the Robot's can_push_button to true" do
    expect(@test_robot.can_push_button).to be false
    @test_robot.allowed_to_push_button
    expect(@test_robot.can_push_button).to be true
  end

  it "#not_allowed_to_push_button will set the Robot's can_push_button to false" do
    @test_robot.allowed_to_push_button
    expect(@test_robot.can_push_button).to be true
    @test_robot.not_allowed_to_push_button
    expect(@test_robot.can_push_button).to be false
  end

  it "#perform_action will simply return when robot has no more buttons to push" do
  end
end