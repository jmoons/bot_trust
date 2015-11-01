require_relative '../test_conductor'

describe "#TestConductor" do

  before :each do
    @test_file_name               = "spec/test_input.txt"
    @string_io_file               = StringIO.new("1\n4 O 2 B 1 B 2 O 4\n1 o 2")
    @file_based_test_conductor    = TestConductor.new( File.open(@test_file_name, "r") )
    @string_based_test_conductor  = TestConductor.new( @string_io_file )
  end

  it "creates test cases" do
    expect(@file_based_test_conductor.test_cases.length).to eq(3)
    expect(@string_based_test_conductor.test_cases.length).to eq(2)
  end

end