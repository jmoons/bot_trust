require_relative '../robot'

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
end