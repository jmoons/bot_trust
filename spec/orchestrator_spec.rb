require_relative '../orchestrator'

describe "#Orchestrator" do

  before :each do
    @test_initializer_string  = "O 2 B 1 B 2 O 4"
    @orchestrator             = Orchestrator.new(@test_initializer_string)
    @correct_orange_buttons   = [2, 4]
    @correct_blue_buttons     = [1, 2]
  end

  it "gives the correct buttons for blue" do
    expect(@orchestrator.blue_buttons).to eq(@correct_blue_buttons)
  end

  it "gives the correct buttons for orange" do
    expect(@orchestrator.orange_buttons).to eq(@correct_orange_buttons)
  end

  it "is not case sensitive for determing a robot" do
    lower_case_initializer_string = "O 45 b 19 B 2 o 41"
    orchestrator = Orchestrator.new(lower_case_initializer_string)

    expect(orchestrator.orange_buttons).to eq([45, 41])
    expect(orchestrator.blue_buttons).to eq([19, 2])
  end
end