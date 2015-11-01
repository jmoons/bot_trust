# 1) Parse the input file and create collection of Test Cases
# 2) For each TestCase, query if complete, if not continue test
# 3) Print out each test's time
require './test_case.rb'
class TestConductor

  VALID_TEST_CASE_EXPRESSION =  /[a-zA-Z]+/

  attr_reader :test_cases

  def initialize(input_file)
    @input_file = input_file
    @test_cases = []
    initialize_test_cases
  end

  private

  def initialize_test_cases
    @input_file.each_line do |input_file_line|
      next unless VALID_TEST_CASE_EXPRESSION.match(input_file_line)
      @test_cases << TestCase.new(input_file_line)
    end
    @input_file.close
  end

end