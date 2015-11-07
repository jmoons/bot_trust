require_relative '../test_case'

describe "#TestCase" do

  before :each do
    @raw_test_case_string         = "4 O 2 B 1 B 2 O 4"
    @normalized_test_case_string  = "O 2 B 1 B 2 O 4"
    @test_case                    = TestCase.new(@raw_test_case_string)
    @test_case_orange_robot       = @test_case.robots.select { |robot| robot.name == "O" }[0]
    @test_case_blue_robot         = @test_case.robots.select { |robot| robot.name == "B" }[0]
    @truth_data_orange_robot      = { name: "O", button_names: [2, 4] }
    @truth_data_blue_robot        = { name: "B", button_names: [1, 2] }

  end

  it "removes trailing/leading whitespace and the number of buttons to be pressed" do
    expect(@test_case.normalized_test_case_description).to eq(@normalized_test_case_string)
  end

  it "#populate_test_case_robots creates correct number of participating robots" do
    expect(@test_case.robots.length).to eq(2)
  end

  it "#populate_test_case_robots creates correct number of robot button presses" do
    expect(@test_case.robots_in_button_press_order.length).to eq(4)
  end

  it "#populate_test_case_robots is case sensitive for names when creating robots" do
    three_robot_test_case_string  = "5 O 2 B 1 o 16 B 2 O 4"
    three_robot_test_case         = TestCase.new(three_robot_test_case_string)
    robot_names                   = three_robot_test_case.robots.map { |robot| robot.name}

    expect(three_robot_test_case.robots.length).to eq(3)
    expect(robot_names).to include("O", "o", "B")
  end

  it "#populate_test_case_robots creates a robot with the supplied name" do
    expect(@test_case_orange_robot.name).to eq( @truth_data_orange_robot[:name] )
    expect(@test_case_blue_robot.name).to eq( @truth_data_blue_robot[:name] )
  end

  it "#populate_test_case_robots creates a robot with the supplied buttons to press" do
    test_case_orange_buttons  = @test_case_orange_robot.buttons_to_press.map{ |button| button.name}
    test_case_blue_buttons    = @test_case_blue_robot.buttons_to_press.map{ |button| button.name}

    expect(test_case_orange_buttons).to eq( @truth_data_orange_robot[:button_names] )
    expect(test_case_blue_buttons).to eq( @truth_data_blue_robot[:button_names] )
  end

  it "#complete? will return false if any robot in the test has buttons to push" do
    expect(@test_case.complete?).to be false
  end

  it "#complete? will return true if all robots in the test have no buttons to push" do
    expect(@test_case.complete?).to be false

    @test_case.robots.each do |robot|
      robot.allowed_to_push_button
      (1 .. robot.buttons_to_press.length).each do |button_to_press_iteration|
        robot.push_button
      end
    end

    expect(@test_case.complete?).to be true
  end
end